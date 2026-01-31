# orchestration-delivery-management

A Helm chart for [order orchestration]/[delivery management] service

**Homepage:** <https://discobole.ow2.io/doc>

## Source Code

* <https://gitlab.ow2.org/discobole/disco-order-orchestration/orchestration-delivery-management>

## Usage

Declare the helm repository:

```bash
helm repo add discobole-stable-repo https://gitlab.ow2.org/api/v4/groups/752345/packages/helm/stable
helm repo update
```

Deploy a release on cluster:

```bash
helm install my-release disco-stable-repo/orchestration-delivery-management
```

## Prerequisites Details

You will need access to a Kubernetes cluster, local or distant (OpenShift, Rancher, GKE, Vanilla Kubernetes, Minikube, MicroK8s, ...) with

- Kubernetes 1.20+

You will need the following installed and configured on your local environment:

- kubectl
- helm 3

Configure your local environment to have `kubectl` access to the target cluster.
For instance, if you wish to deploy to a project named `myproject` on `OpenShift`:

```bash
# first login to OpenShift cluster using your personal OpenShift token
$ oc login
# select the target project
$ oc project myproject
```

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release disco-stable-repo/orchestration-delivery-management
```

The command deploys the application on the Kubernetes cluster in the **default** configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

The following table lists the configurable values of the chart.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| api.contextPath | string | `"/api/v2/"` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `5` |  |
| autoscaling.minReplicas | int | `2` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `70` |  |
| certManager.create | bool | `false` |  |
| contextPath | string | `""` |  |
| fluentd.enabled | bool | `false` |  |
| fluentd.host | string | `"localhost"` |  |
| fluentd.port | string | `""` |  |
| fluentd.sidecar.enabled | bool | `false` |  |
| fluentd.sidecar.loki.extra_labels | string | `"\"env\":\"sandbox\", \"app\": \"disco\""` |  |
| fluentd.sidecar.loki.url | string | `""` |  |
| fluentd.tag | string | `""` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"registry.gitlab.tech.orange/disco/disco-oda-components/disco-order-orchestration/orchestration-delivery-management/snapshot"` |  |
| image.tag | string | `"1-5-0"` |  |
| imagePullSecrets[0].name | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| keycloak.clientId | string | `""` |  |
| keycloak.clientSecret | string | `""` |  |
| keycloak.enabled | bool | `true` |  |
| keycloak.uri | string | `""` |  |
| monitoring.domain | string | `"appli"` |  |
| monitoring.environment | string | `""` |  |
| monitoring.productName | string | `""` |  |
| monitoring.role | string | `"none"` |  |
| monitoring.topology | string | `"none"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| od.service.cpib | string | `""` |  |
| od.service.kafka | string | `"kafka"` |  |
| od.service.mock | string | `""` |  |
| od.service.poi | string | `""` |  |
| od.service.productCatalog | string | `""` |  |
| od.service.spring_json_secret_name | string | `""` |  |
| od.service.userRoleRetrieval | string | `""` |  |
| od.spring_json_secret_name | string | `""` |  |
| otel.enabled | bool | `false` |  |
| otel.sidecar.collector.host | string | `""` |  |
| otel.sidecar.collector.port | string | `nil` |  |
| otel.sidecar.enabled | bool | `false` |  |
| otel.sidecar.exporter | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| registryCredentials.create | bool | `false` |  |
| registryCredentials.token.password | string | `""` |  |
| registryCredentials.token.userName | string | `""` |  |
| registryCredentials.url | string | `""` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"1"` |  |
| resources.limits.memory | string | `"1Gi"` |  |
| resources.requests.cpu | string | `"200m"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| securityContext | object | `{}` |  |
| service.port | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |

Specify each value using the `--set key=value[,key=value]` argument to `helm install`

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml disco-stable-repo/orchestration-delivery-management
```

## Docker image access

These values help you to configure access to the Docker image for this microservice.

- if you need to pull the Docker image from a private or protected registry, you have to create and specify an `imagePullSecret`
- if you wish to let the chart create the image pull secret for you, configure the `serviceAccount.imagePullSecret` section

In case you delegate the creation of an image pull secret, use your own credentials on the private or protected registry, as follows.

```bash
$ helm install my-release disco-stable-repo/orchestration-delivery-management \
--set serviceAccount.imagePullSecret.create=true \
--set serviceAccount.imagePullSecret.registry=<your private or protected docker registry> \
--set serviceAccount.imagePullSecret.username=<you username> \
--set serviceAccount.imagePullSecret.password=<your access token>
```
