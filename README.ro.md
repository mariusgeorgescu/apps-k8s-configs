# apps-k8s-configs

Acest depozit conține configurațiile Kubernetes gestionate de FluxCD pentru aplicații și infrastructură. Structura este orientată pe medii și pe separarea clară între controlere (instalate via Helm) și resurse declarative (YAML simple) aplicate prin Kustomize.

## Structura depozitului

```
apps-k8s-configs/
  apps/
    <app>/
      base/                # manifestele generice ale aplicației (namespace, servicii, rute, workloads)
      dev/                 # overlay de mediu (opțional)
      prod/                # overlay de mediu (producție)
  infrastructure/
    controllers/           # instalări de controlere via Helm (Flux HelmRelease/HelmRepository)
    configs/               # resurse dependente de controlere (ex: ClusterIssuer pentru cert-manager, MetalLB AddressPool)
  clusters/
    <cluster>/
      flux-system/         # bootstrap Flux (generat de flux bootstrap)
      infrastructure/      # Flux Kustomization(s) care aplică infrastructura din repo
      <app>/               # Flux Kustomization(s) pentru aplicații
```

### apps/<app>
- `base/` conține:
  - `namespace.yaml` — spațiul de nume al aplicației
  - `config/` — `ConfigMap`/`Secret` (dacă sunt declarative)
  - `services/` — `Service`-uri
  - `workloads/` — `Deployment`/`StatefulSet`/`Job`
  - `routes/` — `HTTPRoute`/`GRPCRoute` etc. (Gateway API)
  - `networking/gateways/` — `Gateway`-uri (dacă aplicația deține gateway-ul)
  - `policies/` — PDB, NetworkPolicy, etc.
  - `storage/` — `PersistentVolumeClaim`
  - `certificates/` — Certificate (cert-manager)
- `dev/` și `prod/` sunt `Kustomization` cu resursele/patch-urile specifice mediului.

### infrastructure/controllers
- Conține controlere și CRD-uri instalate cu Flux Helm:
  - `traefik-gateway/` — Traefik Gateway Controller (GatewayClass + controller)
  - `coredns/` — CoreDNS (SA/RBAC/Config/Deployment)
  - `local-path/` — Local Path Provisioner (StorageClass implicit)
  - `cert-manager/` — cert-manager (CRD + controller)
  - `cert-manager-godaddy-webhook/` — Webhook GoDaddy pentru solver DNS-01
  - `metallb/` — MetalLB (load balancer L2)

### infrastructure/configs
- Conține resurse dependente de controlerele instalate:
  - `cert-manager/clusterissuer-*.yaml` — `ClusterIssuer` ce folosesc cert-manager

### clusters/<cluster>
- Conține Kustomization-urile Flux care „leagă” repo-ul de cluster:
  - `infrastructure/` — Kustomization-uri Flux pentru controllere (ex: `infrastructure.yaml`, `cert-manager.yaml`, `cert-manager-configs.yaml`, `metallb-configs.yaml`)
  - `<app>/` — Kustomization-uri Flux pentru aplicații (ex: `bjjbackend/bjjbackend-prod.yaml`)

## Conveții de denumire

- **Consistență nume aplicație**: folosește același identificator în tot repo-ul, ex. `bjjbackend` (fără cratime) și menține `metadata.name` aliniat cu numele fișierului.
- **Prefix tip resursă**: include tipul resursei în `metadata.name` și în etichetele podurilor, ex. `bjjbackend-api`, respectiv `bjjbackend-api-pod-label`.
- **Fișiere ↔ resurse**: numele fișierelor reflectă numele resurselor; `metadata.name` corespunde numelui fișierului.
- **Separare**: controlerele/CRD-urile sunt în `infrastructure/controllers`, resursele dependente (ex: `ClusterIssuer`, MetalLB AddressPool) în `infrastructure/configs`.

## FluxCD: cum se aplică

- `clusters/<cluster>/kustomization.yaml` include directoare precum `flux-system`, `infrastructure`, `<app>`.
- `clusters/<cluster>/infrastructure/*.yaml` sunt resurse `Kustomization` Flux care indică părți din repo. Exemple în `minirack`:
  - `infrastructure.yaml` -> `./infrastructure/controllers`
  - `cert-manager.yaml` -> `./infrastructure/controllers/cert-manager`
  - `cert-manager-configs.yaml` -> `./infrastructure/configs/cert-manager`
  - `metallb-configs.yaml` -> `./infrastructure/configs/metallb`
- `infrastructure/kustomization.yaml` agregă controllerele principale și aplică patch-ul pentru `StorageClass` implicit.

## Resurse și scop

- `HelmRepository`/`HelmRelease` (Flux) — instalare de controlere și CRD-uri (ex: cert-manager, Traefik, Gateway API).
- `Kustomization` (Kustomize) — listează resurse YAML din repo pentru aplicații sau infrastructură.
- `Kustomization` (Flux) — declară ce cale din repo trebuie reconciliată în cluster și cu ce interval.
- `GatewayClass`/`Gateway`/`HTTPRoute` — rutare L7 cu Gateway API (Traefik Gateway Controller).
- `ClusterIssuer` (cert-manager) — emite certificate pentru domenii publice sau interne.

## Ghid: adăugarea unei aplicații noi

Presupuneri: ai deja un cluster cu Flux și infrastructura necesară (Traefik Gateway, cert-manager) instalate.

1. Creează structura aplicației
   ```bash
   APP=myapp
   mkdir -p apps/$APP/base/{config,services,workloads,routes,networking/gateways,policies,storage,certificates}
   touch apps/$APP/base/kustomization.yaml
   touch apps/$APP/dev/kustomization.yaml apps/$APP/prod/kustomization.yaml
   ```
2. Definește `namespace` și primele resurse în `apps/$APP/base/`
   - `namespace.yaml` cu `metadata.name: $APP`
   - `services/`, `workloads/`, `routes/` după nevoie
3. Completează `apps/$APP/base/kustomization.yaml`
   ```yaml
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization
   resources:
   - namespace.yaml
   - services/service-<app>-api.yaml
   - workloads/deployment-<app>-api.yaml
   - routes/httproute-<app>-api.yaml
   ```
4. Creează overlay-urile `dev` și `prod`
   ```yaml
   # apps/$APP/dev/kustomization.yaml
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization
   resources:
   - ../base
   ```
   ```yaml
   # apps/$APP/prod/kustomization.yaml
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization
   resources:
   - ../base
   ```
5. Adaugă Kustomization Flux pentru clusterul țintă
   - Creează `clusters/<cluster>/$APP/$APP-dev.yaml` și `clusters/<cluster>/$APP/$APP-prod.yaml` similare cu exemplul `bjjbackend`:
     ```yaml
     apiVersion: kustomize.toolkit.fluxcd.io/v1
     kind: Kustomization
     metadata:
       name: <app>-dev
       namespace: flux-system
     spec:
       interval: 10m0s
       path: ./apps/<app>/dev
       prune: true
       sourceRef:
         kind: GitRepository
         name: flux-system
       wait: true
       timeout: 5m0s
       dependsOn:
       - name: infrastructure
     ```
   - Actualizează `clusters/<cluster>/<app>/kustomization.yaml` să includă cele două fișiere.
6. Respectă convențiile de denumire
   - Folosește identificatorul aplicației fără cratime; include tipul resursei în `metadata.name` și în etichetele podurilor (ex: `<app>-api`).
   - Denumește fișierele conform resursei: `deployment-<app>-api.yaml`, `service-<app>-api.yaml` etc.
7. Commit și reconciliere
   ```bash
   git add .
   git commit -m "feat(<app>): adaugă aplicație și Kustomization-uri Flux"
   git push
   ```
   Flux va reconcilia automat conform `.spec.interval` din Kustomization, sau poți forța reconcilieri cu `flux reconcile`.

## Exemple din repo

- **Aplicație: `bjjbackend`**
  - Base: `apps/bjj/base/`
  - Overlay prod: `apps/bjj/prod`
  - Kustomization Flux: `clusters/minirack/bjjbackend/bjjbackend-prod.yaml`
- Infrastructură:
  - Controller Traefik + Gateway API: `infrastructure/controllers/traefik-gateway/`
  - cert-manager: `infrastructure/controllers/cert-manager/`
  - ClusterIssuer: `infrastructure/configs/cert-manager/`
