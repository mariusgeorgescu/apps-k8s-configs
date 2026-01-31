<!--
SPDX-FileCopyrightText: 2025 Orange SA
SPDX-License-Identifier: MIT

This software is distributed under the MIT License,
the text of which is available at https://opensource.org/license/mit
or see the "LICENSE.txt" file for more details.

Authors: See CONTRIBUTORS.txt
-->

# Authorization-user-role-workflow
[guide-development-workflow](https://gitlab.tech.orange/disco/disco-guide/guide-development-workflow) uses the CI/CD pipelines throughout the [development workflow](https://to-be-continuous.gitlab.io/doc/understand/#development-workflow), by using the Gitflow model .

Also, the Deployment is done with `helm` template, and it implements OAuth Client to access to protected REST resources.

## TL;DR;

Declare the helm repository:

```bash
helm repo add disco-diod-central https://repos.tech.orange/artifactory/disco-virt-helm-stable
```

Deploy a release on **DIOD**:

```bash
helm install Authorization-user-role disco-diod-central/Authorization-user-role
```

## Introduction

This chart bootstraps an deployment on a [OpenShift](http://openshift.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites Details

You will need access to a Kubernetes cluster, local or distant (OpenShift, Rancher, GKE, Vanilla Kubernetes, Minikube, MicroK8s, ...) with

- Kubernetes 1.20+

You will need the following installed and configured on your local environment:

- kubectl
- oc (optional, only recommended if you wish to deploy on DIOD OpenShift)
- helm 3

Configure your local environment to have `kubectl` access to the target cluster.
For instance, if you wish to deploy to a project named myproject on DIOD `OpenShift`:

```bash
# first login to DIOD OpenShift cluster using your personal DIOD OpenShift token
$ oc login
# select the target project
$ oc project myproject
```

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release disco-diod-central/Authorization-user-role
```

The command deploys the application on the Kubernetes cluster in the **default** configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the chart and their default values for `OpenShift` cluster.

### General parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `replicaCount` | number | `1` | The number of replicas for your pod |
| `nameOverride` | string | `""` | Overrides chart name in generated names for resources |
| `fullnameOverride` | string | `""` | Overrides generated names for resources |
| `serviceAccount.create` | boolean | `false` | Specifies whether a service account should be created |
| `serviceAccount.annotations` | object | `{}` | Annotations to add to the service account |
| `serviceAccount.name` | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| `podAnnotations` | object | `{}` | Additional pod annotations for the pods |
| `podSecurityContext` | object | `{}` | Enable security context for the pods |
| `securityContext` | object | `{}` | the container securityContext |
| `service.type` | string | `"ClusterIP"` | the Kubernetes service type |
| `service.port` | number | `8080` | the Kubernetes service port |
| `resources.limits.cpu` | string | `"100m"` | The CPU limit allocated to the container |
| `resources.requests.cpu` | string | `"10m"` | The amount of CPU requested for the container |
| `resources.limits.memory` | string | `"128Mi"` | The memory limit allocated to container |
| `resources.requests.memory` | string | `"128Mi"` | The amount of memory requested for the container |
| `autoscaling.enabled` | boolean | `false` | Set to true and configure according to your needs if you wish to enable pod autoscaling |
| `nodeSelector` | object | `{}` | Node selector for pod assignment |
| `tolerations` | array | `[]` | Tolerations for pod assignment |
| `affinity` | object | `{}` | Set if you wish to configure pod affinity and anti-affinity |

### Docker parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `image.repository` | string | `${docker_repository}` | The docker image repository |
| `image.pullPolicy` | string | `Always` | The pull policy |
| `image.tag` | string | `${docker_tag}` | The image tag (immutable tags are recommended) |
| `imagePullSecrets` | array | `[]` | Specify docker-registry secret names as an array  |
| `registryCredentials.create` | boolean | `false` | Set to `true` if you want this chart to create an image pull secret for you (then supply the information below) |
| `registryCredentials.url` | string | `nil` | (if `registryCredentials.create=true`) The url for the Docker registry |
| `registryCredentials.token.userName` | string | `nil` | (if `registryCredentials.create=true`) The user name to access the Docker registry |
| `registryCredentials.token.password` | string | `nil` | (if `registryCredentials.create=true`) The password to access the Docker registry |
| `rollme` | boolean | `false` | Set to `true` if you want to automatically roll deployments |

### Service parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `certManager.create` | boolean | `false` | If cert-manager is available, enable the creation of Certificate Signing Requests for exposed endpoints |
| `certManager.clusterIssuer` | string | `nil` | (if `certManager.create=true`) Specify the name of cluster-wide issuer for certificates |
| `istio.enabled` | boolean | `false` | Set to true if using istio gateway to expose your service. Istio config below needs to be supplied |
| `istio.paths` | array | `nil` | Used to route traffic using matching rules based on prefix (align with `contextPath`) |
| `istio.hosts` | array | `nil` | Host names used to expose the service with Istio |
| `istio.tls` | array | `nil` | Specifies (per host) information to secure endpoints with TLS |
| `istio.tls.secretName` | string | `nil` | Name of secret containing TLS certificate (for a given host) |
| `istio.tls.commonName` | string | `nil` | Certificate common name (when using cert-manager) |
| `istio.tls.securePortName` | string | `nil` | Name of secure port being exposed |
| `istio.tls.hosts` | array | `nil` | Host being secured with TLS  |
| `ingress.enabled` | boolean | `false` | Set to true if using ingress controller to expose your service. Ingress config below needs to be supplied |
| `ingress.annotations` | object | `nil` | Annotations to add to the ingress (`kubernetes.io/ingress.class: nginx` if using NGINX ingress controller, and `cert-manager.io/cluster-issuer: my-ca-issuer`if using cert-manager) |
| `ingress.hosts` | array | `nil` | Lists combinations of host/path used to route traffic (based on prefix) to this service with ingress |
| `ingress.hosts.paths` | array | `nil` | Path used with a given host, used for routing traffic (align with `contextPath`) |
| `ingress.hosts.host` | string | `nil` | Specifies routing rules for a given host name |
| `ingress.tls` | array | `nil` | Specifies (per host) information to secure endpoints with TLS |
| `ingress.tls.secretName` | string | `nil` | Name of secret containing TLS certificate (for a given host) |
| `ingress.tls.hosts` | array | `nil` | Host being secured with TLS  |

### Keycloak parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `keycloak.enabled`                      | boolean | `false` | Set to true if you want to enable authentication and authorization with `Keycloak`                                                               |
| `keycloak.clientId`                      | string | `nil` | Specifies the client ID set in `Keycloak`                                                               |
| `keycloak.Secret`                      | string | `nil` | Specifies the client secret set in `Keycloak`                                                               |
| `keycloak.issuerURI`                      | string | `nil` | Specifies the provider issuer URI provided by `Keycloak`                                                               |
### Java keystore parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `keyStoreP12`                      | string | `nil` | Set JVM keystore in PKCS12 format with the Root certificate for JVM communication                                                               |
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install my-release disco-diod-central/Authorization-user-role
    --set keyStoreP12=<value> \
```

The above command inject the keystore into the pod.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml disco-diod-central/Authorization-user-role
```

## Docker image access

These values help you to configure access to the Docker image for this microservice.

- by default, the Docker image will be pulled from the DIOD Central Registry (which is public within Orange)
- if you ever need to pull the Docker image from a private or protected registry, you have to create and specify an `imagePullSecret`
- if you wish to let the chart create the image pull secret for you, configure the `registryCredentials` section

In case you delegate the creation of an image pull secret, use your own credentials on the private or protected registry (here `disco-virt-docker-stable.repos.tech.orange`), as follows.

```bash
$ helm install --name my-release disco-diod-central/Authorization-user-role \
--set registryCredentials.create=true \
--set registryCredentials.url=disco-virt-docker-stable.repos.tech.orange \
--set registryCredentials.token.username=<you username> \
--set registryCredentials.token.password=<your access token> 
```

## Observability

The application can use [opentelemetry](https://opentelemery.io) for tracing, metrics and logging.

```bash
$ helm install --name my-release disco-diod-central\Authorization-user-role \
    --set otel.enabled=true --set fluentd.enabled=true 
```

## Security

The application supports the authentication and authorization by setting credentials provided by [keycloak](https://www.keycloak.org/).

```bash
$ helm install --name my-release disco-diod-central/Authorization-user-role \
    --set keycloak.enabled=true \
    --set keycloak.clientId=<the client ID set in Keycloak> \
    --set keycloak.clientSecret=<the client secret set in Keycloak> \
    --set keycloak.issuerURI=<the issuer URI set in Keycloak> 
```
