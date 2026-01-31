<!--
SPDX-FileCopyrightText: 2025 Orange SA
SPDX-License-Identifier: MIT

This software is distributed under the MIT License,
the text of which is available at https://opensource.org/license/mit
or see the "LICENSE.txt" file for more details.

Authors: See CONTRIBUTORS.txt
-->

# order-capture

A Helm chart for [order management]/[order capture] service

## Usage

Declare the helm repository:

```bash
helm repo add discobole-stable-repo https://gitlab.ow2.org/api/v4/groups/5972/packages/helm/stable
helm repo update
```

Deploy a release on cluster:

```bash
helm install my-release discobole-stable-repo/order-capture
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
$ helm install my-release discobole-stable-repo/order-capture
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
| image.repository | string | `"registry.gitlab.tech.orange/disco/disco-oda-components/disco-order-management/order-capture/snapshot"` |  |
| image.tag | string | `"1-15-0"` |  |
| imagePullSecrets[0].name | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| keycloak.clientSecret | string | `""` |  |
| keycloak.enabled | bool | `false` |  |
| keycloak.url | string | `""` |  |
| mongo.architecture | string | `"standalone"` |  |
| mongo.auth.enabled | bool | `false` |  |
| mongo.auth.rootPassword | string | `""` |  |
| mongo.auth.rootUser | string | `""` |  |
| mongo.commonLabels.domain | string | `"dbms"` |  |
| mongo.commonLabels.productname | string | `"mongodb"` |  |
| mongo.directoryPerDB | bool | `true` |  |
| mongo.enabled | bool | `false` |  |
| mongo.extraEnvVarsSecret | string | `""` |  |
| mongo.fullnameOverride | string | `""` |  |
| mongo.initdbScripts."init.js" | string | `""` |  |
| mongo.podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| mongo.podAnnotations."prometheus.io/port" | string | `"9216"` |  |
| mongo.podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| mongo.resources.limits.memory | string | `"1500Mi"` |  |
| mongo.service.nameOverride | string | `""` |  |
| mongo.service.ports.mongodb | int | `27017` |  |
| mongo.useStatefulSet | bool | `true` |  |
| monitoring.domain | string | `"appli"` |  |
| monitoring.environment | string | `""` |  |
| monitoring.productName | string | `""` |  |
| monitoring.role | string | `"none"` |  |
| monitoring.topology | string | `"none"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| oc.service.authUserRole | string | `""` |  |
| oc.service.kafka | string | `""` |  |
| oc.service.mockServer | string | `""` |  |
| oc.service.mxHeap | string | `""` |  |
| oc.service.poi | string | `""` |  |
| oc.service.productCatalog | string | `""` |  |
| oc.service.productConfigurator | string | `""` |  |
| oc.service.productInventory | string | `""` |  |
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
| resources.limits.cpu | string | `"600m"` |  |
| resources.limits.memory | string | `"1Gi"` |  |
| resources.requests.cpu | string | `"200m"` |  |
| resources.requests.memory | string | `"500Mi"` |  |
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
$ helm install my-release -f values.yaml discobole-stable-repo/order-capture
```

## Docker image access

These values help you to configure access to the Docker image for this microservice.

- if you need to pull the Docker image from a private or protected registry, you have to create and specify an `imagePullSecret`
- if you wish to let the chart create the image pull secret for you, configure the `serviceAccount.imagePullSecret` section

In case you delegate the creation of an image pull secret, use your own credentials on the private or protected registry, as follows.

```bash
$ helm install my-release discobole-stable-repo/order-capture \
--set serviceAccount.imagePullSecret.create=true \
--set serviceAccount.imagePullSecret.registry=<your private or protected docker registry> \
--set serviceAccount.imagePullSecret.username=<you username> \
--set serviceAccount.imagePullSecret.password=<your access token>
```
