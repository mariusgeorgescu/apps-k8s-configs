# Ghid: Deploy GitOps pe un cluster k3s HA (5x Raspberry Pi)

Acest ghid descrie pașii pentru a porni un cluster k3s High Availability pe 5 Raspberry Pi și pentru a aplica infrastructura și aplicațiile din acest repo prin GitOps (FluxCD), fără modificări manuale în cluster (exceptând bootstrapul Flux și secretele necesare pentru SOPS/ACME, o singură dată).

Presupuneri:
- 5x Raspberry Pi 4/5 (64-bit OS), stocare rapidă (SSD) recomandat.
- Rețea LAN 192.168.1.0/24 (ajustează după caz).
- 3 noduri control-plane + 2 noduri worker.
- Adresă VIP API server: 192.168.1.200 (gestionată ulterior de `keepalived`).
- Pool MetalLB: 192.168.1.240-192.168.1.250, cu IP fix pentru Traefik: 192.168.1.240.

Notă: Toate schimbările funcționale se fac prin GitOps (commit-uri în repo). Evită `kubectl apply` direct peste resurse din repo.

## 1) Pregătire hardware și OS

- Instalează Raspberry Pi OS Lite 64-bit sau Ubuntu Server 64-bit pe fiecare Pi.
- Setează hostname-uri unice (ex: `rpi-cp1`, `rpi-cp2`, `rpi-cp3`, `rpi-w1`, `rpi-w2`).
- Configurează IP static sau rezervări DHCP. Activează SSH.
- Verifică cgroups (de regulă OK implicit pe OS moderne):
  - `/boot/cmdline.txt` să includă `cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory` (Raspberry Pi OS)
- Sincronizează timpul (NTP activat implicit).

## 2) Instalare k3s HA cu etcd embedded

Alege 3 noduri control-plane (CP). Inițializează primul CP:

```bash
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server \
  --cluster-init \
  --tls-san 192.168.1.200 \
  --node-ip <CP1_IP> \
  --advertise-address <CP1_IP> \
  --disable servicelb \
  --disable traefik" sh -
```

- Obține tokenul de cluster pe CP1: `sudo cat /var/lib/rancher/k3s/server/node-token`.
- Pe CP2 și CP3, pornește ca servere HA și indică IP-ul CP1 (temporar) sau VIP (dacă există deja):

```bash
export K3S_TOKEN=<TOKEN_DE_PE_CP1>
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server \
  --server https://<CP1_IP>:6443 \
  --tls-san 192.168.1.200 \
  --node-ip <CPx_IP> \
  --advertise-address <CPx_IP> \
  --disable servicelb \
  --disable traefik" sh -
```

- Pe cele 2 noduri worker:

```bash
export K3S_TOKEN=<TOKEN_DE_PE_CP1>
curl -sfL https://get.k3s.io | K3S_URL=https://<CP1_IP>:6443 sh -
```

După ce VIP-ul API va fi gestionat de `keepalived`, poți reconfigura kubeconfig-ul local pentru a indica `https://192.168.1.200:6443`.

## 3) Bootstrap FluxCD (GitOps)

- Instalează CLI Flux pe stația ta și configurează accesul la cluster (kubeconfig de pe CP1, ex. `sudo cat /etc/rancher/k3s/k3s.yaml`).
- Opțiunea A (recomandat): `flux bootstrap github` către acest repo.
- Opțiunea B (repo deja pregătit): aplică manifestele generate din `clusters/minirack/flux-system/`:

```bash
kubectl apply -f clusters/minirack/flux-system/gotk-components.yaml
kubectl apply -f clusters/minirack/flux-system/gotk-sync.yaml
```

Repo-ul este sursa adevărului: `clusters/minirack/kustomization.yaml` va include infrastructura și aplicațiile.

## 4) SOPS + cheie age (decriptare secrete)

Acest repo folosește SOPS pentru secrete (ex: token GoDaddy). Creează o cheie age local și instaleaz-o ca secret Flux o singură dată [[memory:9046851]]:

```bash
age-keygen -o age.key
kubectl -n flux-system create secret generic sops-age \
  --from-file=age.agekey=age.key
```

- Asigură-te că recipientul public age din fișierele SOPS corespunde cheii tale publice din `age.key`.
- Alternativ, dacă cheia există deja în repo/echipă, folosește aceeași cheie.

## 5) Infrastructură prin GitOps (automat)

După ce Flux este „Ready”, acesta va instala controlerele definite în repo:
- Traefik Gateway Controller (`infrastructure/controllers/traefik-gateway/`) cu Service `LoadBalancer` fix: 192.168.1.240
- MetalLB (`infrastructure/controllers/metallb/`) + configs (`infrastructure/configs/metallb/`):
  - `IPAddressPool`: 192.168.1.240-192.168.1.250
  - `L2Advertisement`: pentru poolul de mai sus
- cert-manager + webhook GoDaddy (ACME DNS-01)
- CoreDNS, Local Path Provisioner (StorageClass implicit), Prometheus stack
- Keepalived DaemonSet pentru VIP API 192.168.1.200 (control-plane)

Important:
- K3s `servicelb` este dezactivat (folosim MetalLB); există și un override pentru Service-ul Traefik din `kube-system` la `ClusterIP` pentru a evita conflicte (`infrastructure/configs/k3s/service-traefik-clusterip.yaml`).
- Traefik din acest repo rulează în namespace `traefik`, instalat via HelmRelease și expus prin MetalLB cu IP fix 192.168.1.240.

Poți forța reconcilierea dacă vrei să grăbești instalarea:
```bash
flux reconcile kustomization infrastructure -n flux-system
flux reconcile kustomization metallb-configs -n flux-system
flux reconcile kustomization cert-manager -n flux-system
flux reconcile kustomization cert-manager-configs -n flux-system
```

## 6) Secrete și certificate (cert-manager)

- Token-ul GoDaddy este stocat cu SOPS în `infrastructure/configs/cert-manager/secret-godaddy-api-token.yaml`. Asigură-te că Flux poate decripta (pasul 4).
- Issuers sunt în `infrastructure/configs/cert-manager/clusterissuer-godaddy-*.yaml` (staging/prod). Verifică email-ul și domeniile.

După ce cert-manager și webhook-ul sunt Ready, certificatele pentru rutele publice vor fi emise automat pe baza resurselor `Certificate`/`HTTPRoute` din overlay-urile aplicațiilor.

## 7) Keepalived (VIP API 192.168.1.200)

Repo-ul include două variante conceptuale:
- Un `DaemonSet` simplificat ce atașează/eliberează VIP-ul 192.168.1.200 pe `eth0` când API-ul local e sănătos (`infrastructure/controllers/keepalived/daemonset-keepalived.yaml`).
- Un `ConfigMap` cu configurație VRRP clasică (`infrastructure/controllers/keepalived/configmap-keepalived.yaml`).

În configurația curentă, `DaemonSet` este cel aplicat. Asigură-te că interfața este `eth0` pe control-plane-uri. Dacă interfața are alt nume (ex. `enp2s0`), actualizează manifestul înainte de deploy.

Ordinea practică:
1. Pornește clusterul HA folosind IP-ul CP1 ca endpoint temporar.
2. Flux instalează `keepalived` via GitOps.
3. După ce `DaemonSet/keepalived` e Ready pe control-plane-uri, VIP 192.168.1.200 devine endpoint-ul HA (`https://192.168.1.200:6443`). Poți actualiza kubeconfig-ul local.

## 8) Rutare L7 cu Traefik Gateway + app overlays

Aplicațiile au overlay-uri `dev/prod` cu resurse Gateway API (conform convenției că manifestele de networking stau în `networking/` din overlay-ul aplicației) [[memory:8771969]].
- `GatewayClass` este creat de traefik-gateway controller.
- `Gateway` și `HTTPRoute` pentru fiecare aplicație sunt în `apps/<app>/<env>/networking/{gateways,routes,certificates}`.

Asigură-te că folosești portul numit `http` pentru `targetPort` și probe, consecvent în `Deployment`, `Service` și rute [[memory:8672645]].

## 9) Verificări post-instalare

- Noduri și roluri:
  ```bash
  kubectl get nodes -o wide
  ```
- Flux și Kustomization-uri:
  ```bash
  flux get kustomizations -A
  ```
- MetalLB și serviciul Traefik (IP 192.168.1.240):
  ```bash
  kubectl -n traefik get svc
  ```
- cert-manager și certificate:
  ```bash
  kubectl -n cert-manager get pods
  kubectl get certificate -A
  ```
- Keepalived VIP:
  ```bash
  kubectl -n kube-system get ds keepalived -o wide
  ip addr show eth0 | grep 192.168.1.200  # rulat pe un control-plane
  ```

## 10) Bootstrap aplicații

Aplicațiile incluse (ex: `bjjbackend`, `bjj-dapp-web`, `entangled-frontend`) au deja Kustomization-uri în `clusters/minirack/<app>/`. După ce infrastructura este Ready, Flux va reconcilia și aceste aplicații automat.

Dacă adaugi aplicații noi, urmează ghidul din `README.ro.md` (secțiunea „Ghid: adăugarea unei aplicații noi”).

## 11) Observații operaționale

- Toate modificările merg prin Git (GitOps). Nu modifica resursele din repo prin `kubectl edit`/`apply` manual.
- Când schimbi IP-urile (VIP sau MetalLB pool), actualizează fișierele relevante:
  - `infrastructure/controllers/traefik-gateway/helmrelease-traefik-gateway.yaml` (câmpurile `service.loadBalancerIP` și adnotările `metallb.io/address-pool`)
  - `infrastructure/configs/metallb/ipaddresspool-prod.yaml`
  - `infrastructure/controllers/keepalived/daemonset-keepalived.yaml` și/sau `configmap-keepalived.yaml`
- Pentru secrete SOPS, păstrează cheia age în siguranță și sincronizată între operatori.

---

Ancore rapide:
- Bootstrap Flux: `clusters/minirack/flux-system/`
- Infra orchestration: `clusters/minirack/infrastructure/`
- Controlere: `infrastructure/controllers/`
- Configuri (MetalLB, cert-manager, k3s): `infrastructure/configs/`
- Aplicații: `apps/`

