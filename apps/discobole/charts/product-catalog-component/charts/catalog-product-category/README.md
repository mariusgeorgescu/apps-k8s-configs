<!--
SPDX-FileCopyrightText: 2025 Orange SA
SPDX-License-Identifier: MIT

This software is distributed under the MIT License,
the text of which is available at https://opensource.org/license/mit
or see the "LICENSE.txt" file for more details.

Authors: See CONTRIBUTORS.txt
-->

# catalog-product-category

A Helm chart for [disco-catalog]/[catalog product category] service

**Homepage:** <https://discobole.ow2.io/doc>

## Source Code

* <https://gitlab.ow2.org/discobole/disco-catalog/catalog-product-category/>

## Usage

Declare the helm repository:

```bash
helm repo add discobole-stable-repo https://gitlab.ow2.org/api/v4/groups/752345/packages/helm/stable
helm repo update
```

Deploy a release on cluster:

```bash
helm install my-release disco-stable-repo/catalog-product-category
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
$ helm install my-release disco-stable-repo/catalog-product-category
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
| DISCO_DEV_CATALOG_MONGO_PASSWORD | string | `""` |  |
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `5` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| contextPath | string | `""` |  |
| dailyshutdown | string | `"enabled"` |  |
| database.enabled | bool | `true` |  |
| database.rootPassword | string | `""` |  |
| database.rootUser | string | `"mongo_user"` |  |
| fluentd.enabled | bool | `true` |  |
| fluentd.host | string | `"apps-fluentd"` |  |
| fluentd.tag | string | `"product-offering"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"registry.gitlab.tech.orange/disco/disco-oda-components/disco-catalog/catalog-product-category"` |  |
| image.tag | string | `"1.7.0"` |  |
| imagePullSecrets[0].name | string | `"discoregistry-imagepuller"` |  |
| imagePullSecrets[1].name | string | `"default-dockercfg-b7fws"` |  |
| ingress.annotations."route.openshift.io/insecureEdgeTerminationPolicy" | string | `"Redirect"` |  |
| ingress.annotations."route.openshift.io/termination" | string | `"edge"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"product-category-disco.apps.fr01.paas.tech.orange"` |  |
| ingress.hosts[0].paths[0] | string | `"/"` |  |
| keyStoreP12 | string | `""` |  |
| monitoring.application | string | `""` |  |
| monitoring.domain | string | `""` |  |
| monitoring.environment | string | `""` |  |
| monitoring.productName | string | `""` |  |
| monitoring.role | string | `""` |  |
| monitoring.topology | string | `""` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| otel.attributes.cluster | string | `"diod-openshift"` |  |
| otel.attributes.hostname | string | `""` |  |
| otel.attributes.namespace | string | `""` |  |
| otel.attributes.platform | string | `"openshift"` |  |
| otel.attributes.region | string | `""` |  |
| otel.enabled | bool | `true` |  |
| otel.sidecar.enabled | bool | `false` |  |
| otel.sidecar.jaeger.host | string | `"jaeger"` |  |
| otel.sidecar.jaeger.port | int | `14250` |  |
| otel.sidecar.otlp.host | string | `"disco-tracing-otel"` |  |
| otel.sidecar.otlp.port | int | `4317` |  |
| podAnnotations."prometheus.io/port" | string | `"9000"` |  |
| podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| podAnnotations.metrics | string | `"/actuator/prometheus"` |  |
| podSecurityContext | object | `{}` |  |
| promtail.enabled | bool | `false` |  |
| promtail.enabled | bool | `false` |  |
| replicaCount | string | `""` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"300Mi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| securityContext | object | `{}` |  |
| service.annotations."prometheus.io/port" | string | `"9000"` |  |
| service.annotations."prometheus.io/scrape" | string | `"true"` |  |
| service.port | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `"ci-cd"` |  |
| services.catalogui | string | `""` |  |
| services.category | string | `""` |  |
| services.catprodcaturl | string | `""` |  |
| services.dbname | string | `"catalog"` |  |
| services.gateway | string | `""` |  |
| services.kafka | string | `""` |  |
| services.keycloak | string | `"keycloak:80"` |  |
| services.keycloakrealm | string | `""` |  |
| services.keycloakroute | string | `""` |  |
| services.lifecycle | string | `""` |  |
| services.mockservice | string | `""` |  |
| services.mongodb | string | `"catalog-mongo"` |  |
| services.offering | string | `""` |  |
| services.offeringprice | string | `""` |  |
| services.productcatalog | string | `""` |  |
| services.specification | string | `""` |  |
| services.userroleretrieve | string | `""` |  |
| tolerations | list | `[]` |  |

Specify each value using the `--set key=value[,key=value]` argument to `helm install`

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml disco-stable-repo/catalog-product-category
```

## Docker image access

These values help you to configure access to the Docker image for this microservice.

- if you need to pull the Docker image from a private or protected registry, you have to create and specify an `imagePullSecret`
- if you wish to let the chart create the image pull secret for you, configure the `serviceAccount.imagePullSecret` section

In case you delegate the creation of an image pull secret, use your own credentials on the private or protected registry, as follows.

```bash
$ helm install my-release disco-stable-repo/catalog-product-category \
--set serviceAccount.imagePullSecret.create=true \
--set serviceAccount.imagePullSecret.registry=<your private or protected docker registry> \
--set serviceAccount.imagePullSecret.username=<you username> \
--set serviceAccount.imagePullSecret.password=<your access token>
```
