# DISCOBOLE Stack Deployment Handoff

This document describes the GitOps setup completed for deploying the DISCOBOLE Stack R9 to a k3s cluster using Flux CD, and outlines the remaining steps to complete the deployment.

---

## What Was Done

### 1. Created GitOps Structure

A complete GitOps structure was created in `/Users/mg/Projects/apps-k8s-configs/apps/discobole/` with the following layout:

```
apps/discobole/
├── base/
│   ├── kustomization.yaml
│   └── namespace.yaml                    # Creates 'disco' namespace
├── charts/                               # Helm charts copied from discobole-stack
│   ├── admin-ui/
│   ├── auth-userrole/
│   ├── disco-gateway/
│   ├── om-mock-server/
│   ├── order-management-component/
│   ├── order-orchestration-component/
│   ├── product-catalog-component/
│   ├── product-catalog-ui/
│   ├── product-configurator/
│   └── product-inventory/
└── prod/
    ├── kustomization.yaml
    ├── helmreleases/                     # 10 HelmRelease manifests
    ├── infrastructure/                   # Keycloak, Kafka, MinIO deployments
    ├── networking/                       # Certificates, Gateways, HTTPRoutes
    └── secrets/                          # 4 secrets (need SOPS encryption)
```

### 2. Cluster Integration

- Added `discobole` to `/Users/mg/Projects/apps-k8s-configs/clusters/minirack/kustomization.yaml`
- Created Flux Kustomization at `/Users/mg/Projects/apps-k8s-configs/clusters/minirack/discobole/discobole-prod.yaml`

### 3. Networking Configuration

Created Gateway API resources for 5 domains:

| Domain | Service | Port | Purpose |
|--------|---------|------|---------|
| disco-keycloak.e7d.tech | keycloak | 80 | Keycloak auth & admin |
| disco-api.e7d.tech | disco-gateway | 8080 | Main API Gateway |
| disco-auth-api.e7d.tech | auth-userrole | 8080 | User Role Management API |
| disco-admin.e7d.tech | admin-ui | 80 | Admin Portal UI |
| disco-pc.e7d.tech | product-catalog-ui | 80 | Product Catalog UI |

For each domain:
- Certificate (cert-manager with letsencrypt-http01-prod ClusterIssuer)
- Gateway (Traefik gatewayClassName)
- HTTPRoute (HTTPS traffic)
- HTTPRoute (HTTP to HTTPS redirect)

### 4. Infrastructure Components

Created raw Kubernetes manifests for:
- **PostgreSQL** - Database for Keycloak (`infrastructure/keycloak/postgres.yaml`)
- **Keycloak** - Identity provider (`infrastructure/keycloak/keycloak.yaml`)
- **Zookeeper** - Kafka coordination (`infrastructure/kafka/zookeeper.yaml`)
- **Kafka** - Message broker (`infrastructure/kafka/kafka.yaml`)
- **MinIO** - S3-compatible storage (`infrastructure/minio/minio.yaml`)

### 5. HelmReleases

Created HelmReleases for all application components, referencing local charts:
- disco-gateway
- product-catalog (8 microservices + MongoDB)
- auth-userrole (+ MongoDB)
- admin-ui
- product-catalog-ui
- product-configurator
- product-inventory (+ MongoDB)
- order-management (3 services)
- order-orchestration (2 services)
- mock-server

All HelmReleases use:
```yaml
chart:
  spec:
    chart: ./apps/discobole/charts/<chart-name>
    sourceRef:
      kind: GitRepository
      name: flux-system
      namespace: flux-system
```

### 6. Secrets (NOT YET ENCRYPTED)

Created 4 secret files with real values in `prod/secrets/`:
- `secret-gar-access.yaml` - Google Artifact Registry credentials (copied from discobole-stack)
- `secret-postgres.yaml` - PostgreSQL password: `keycloakpass`
- `secret-keycloak-admin.yaml` - Keycloak admin password: `adminpassword`
- `secret-minio.yaml` - MinIO credentials: `minio-access-key` / `minio-secret-key`

**IMPORTANT**: These secrets are in plaintext and MUST be encrypted with SOPS before committing!

### 7. Bruno Environments

Created `k3s-prod.bru` environment files for all 4 Bruno collections in `/Users/mg/Projects/discobole-stack/userrole-creation-collections/`:
- UserRoleCreationCollection_Catalog
- UserRoleCreationCollection_Configurator
- UserRoleCreationCollection_COOD
- UserRoleCreationCollection_ProductInventory

---

## Remaining Steps to Complete Deployment

### Step 1: Encrypt Secrets with SOPS

```bash
cd /Users/mg/Projects/apps-k8s-configs/apps/discobole/prod/secrets

# Encrypt all secret files
sops -e -i secret-gar-access.yaml
sops -e -i secret-postgres.yaml
sops -e -i secret-keycloak-admin.yaml
sops -e -i secret-minio.yaml

# Verify encryption
head -5 secret-postgres.yaml  # Should show "sops:" metadata
```

### Step 2: Configure DNS Records

Add A records pointing to the k3s cluster's public IP (or the MetalLB load balancer IP if NAT'd):

```
disco-keycloak.e7d.tech  A  <public-ip>
disco-api.e7d.tech       A  <public-ip>
disco-auth-api.e7d.tech  A  <public-ip>
disco-admin.e7d.tech     A  <public-ip>
disco-pc.e7d.tech        A  <public-ip>
```

### Step 3: Commit and Push

```bash
cd /Users/mg/Projects/apps-k8s-configs
git add .
git commit -m "Add DISCOBOLE stack with embedded Helm charts"
git push
```

### Step 4: Monitor Flux Reconciliation

```bash
# Watch Flux reconcile
flux get kustomizations --watch

# Check specifically for discobole
flux get kustomization discobole-prod

# Check HelmReleases
kubectl get helmreleases -n disco

# Watch pods come up
kubectl get pods -n disco -w
```

### Step 5: Troubleshoot if Needed

```bash
# Check HelmRelease status
kubectl describe helmrelease <name> -n disco

# Check Flux logs
flux logs --kind=Kustomization --name=discobole-prod

# Check pod logs
kubectl logs <pod-name> -n disco
```

### Step 6: Configure Keycloak (One-time Setup)

Once Keycloak is running at https://disco-keycloak.e7d.tech:

1. **Login to Keycloak Admin Console**
   - URL: https://disco-keycloak.e7d.tech/admin/
   - Username: `admin`
   - Password: `adminpassword`

2. **Create SpringBootKeycloak Realm**
   - Click "Create Realm"
   - Name: `SpringBootKeycloak`
   - Enabled: ON

3. **Create Gateway Client** (confidential)
   - Clients → Create client
   - Client ID: `gateway`
   - Client authentication: ON
   - Direct access grants: ON
   - Service accounts roles: ON
   - Valid redirect URIs: `*`
   - Web origins: `*`
   - Save and copy the Client Secret from Credentials tab

4. **Create disco-frontend Client** (public)
   - Client ID: `disco-frontend`
   - Client authentication: OFF
   - Standard flow: ON
   - Direct access grants: ON
   - Valid redirect URIs: `https://disco-pc.e7d.tech/*`
   - Web origins: `https://disco-pc.e7d.tech`

5. **Create admin-ui Client** (public)
   - Client ID: `admin-ui`
   - Client authentication: OFF
   - Standard flow: ON
   - Direct access grants: ON
   - Valid redirect URIs: `https://disco-admin.e7d.tech/*`
   - Web origins: `https://disco-admin.e7d.tech`

6. **Create admin-test User**
   - Users → Add user
   - Username: `admin-test`
   - Email: `admin-test@disco.local`
   - Email verified: ON
   - First name: `Admin`
   - Last name: `Test`
   - Credentials tab → Set password: `adminpassword` (temporary: OFF)
   - Role mappings → Assign realm-management roles

7. **Update Realm Frontend URL**
   - Realm settings → General
   - Frontend URL: `https://disco-keycloak.e7d.tech`

### Step 7: Update Gateway Client Secret

After getting the gateway client secret from Keycloak:

```bash
cd /Users/mg/Projects/apps-k8s-configs/apps/discobole/prod/helmreleases

# Edit helmrelease-disco-gateway.yaml
# Change: KEYCLOAK_CLIENT_SECRET: "REPLACE_WITH_GATEWAY_CLIENT_SECRET"
# To:     KEYCLOAK_CLIENT_SECRET: "<actual-secret-from-keycloak>"

# Commit and push
git add helmrelease-disco-gateway.yaml
git commit -m "Update gateway client secret"
git push
```

### Step 8: Run Bruno Collections to Create Roles

```bash
cd /Users/mg/Projects/discobole-stack/userrole-creation-collections

# Update client_secret in each environments/k3s-prod.bru file with the gateway secret

# Run collections using Bruno CLI or GUI with k3s-prod environment:
# 1. UserRoleCreationCollection_Catalog
# 2. UserRoleCreationCollection_Configurator
# 3. UserRoleCreationCollection_COOD
# 4. UserRoleCreationCollection_ProductInventory
```

### Step 9: Verify Deployment

Access the UIs:
- Admin UI: https://disco-admin.e7d.tech
- Product Catalog UI: https://disco-pc.e7d.tech
- Keycloak Admin: https://disco-keycloak.e7d.tech/admin/

Login with: `admin-test` / `adminpassword`

---

## Important Notes

### Image Pull Secret
The `gar-access` secret contains credentials for Google Artifact Registry where the DISCOBOLE images are hosted. All HelmReleases reference this secret via `imagePullSecrets`.

### Dependencies
The Flux Kustomization (`discobole-prod.yaml`) depends on:
- `infrastructure` - Core cluster infrastructure
- `cert-manager` - For TLS certificate management

### Resource Requirements
The full stack requires significant resources:
- RAM: 16GB+ recommended
- CPU: 4+ cores
- Storage: 50GB+ for all PVCs

### Helm Chart Dependencies
Some charts have OCI registry dependencies (e.g., product-catalog-component references `registry.gitlab.tech.orange`). If these fail:
1. Run `helm dependency build` locally on each chart
2. Commit the downloaded charts to the `charts/` directory

---

## File Locations Summary

| Path | Purpose |
|------|---------|
| `/Users/mg/Projects/apps-k8s-configs/apps/discobole/` | Main discobole app directory |
| `/Users/mg/Projects/apps-k8s-configs/apps/discobole/charts/` | Embedded Helm charts |
| `/Users/mg/Projects/apps-k8s-configs/apps/discobole/prod/secrets/` | Secrets (need SOPS encryption) |
| `/Users/mg/Projects/apps-k8s-configs/clusters/minirack/discobole/` | Flux Kustomization |
| `/Users/mg/Projects/discobole-stack/userrole-creation-collections/` | Bruno collections for role creation |

---

*Document created: 2026-01-31*
