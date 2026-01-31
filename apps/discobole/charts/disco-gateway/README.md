<!--
SPDX-FileCopyrightText: 2025 Orange SA
SPDX-License-Identifier: MIT

This software is distributed under the MIT License,
the text of which is available at https://opensource.org/license/mit
or see the "LICENSE.txt" file for more details.

Authors: See CONTRIBUTORS.txt
-->

# disco-gateway

A Helm chart for gateway

**Homepage:** <https://gitlab.tech.orange/disco/disco-gateway/disco-gateway>

## Source Code

* <https://gitlab.tech.orange/disco/disco-gateway/disco-gateway>

## Usage

Declare the helm repository:

```bash
helm repo add discobole-stable-repo https://gitlab.ow2.org/api/v4/groups/5972/packages/helm/stable
helm repo update
```

Deploy a release on cluster:

```bash
helm install my-release discobole-stable-repo/disco-gateway
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
$ helm install my-release discobole-stable-repo/disco-gateway
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
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `5` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| contextPath | string | `""` |  |
| dailyshutdown | string | `"enabled"` |  |
| envType | string | `""` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"registry.gitlab.tech.orange/disco/disco-oda-components/spring-cloud-gateway/snapshot"` |  |
| image.tag | string | `"1-7-0"` |  |
| imagePullSecrets[0].name | string | `"discoregistry-imagepuller"` |  |
| imagePullSecrets[1].name | string | `"default-dockercfg-b7fws"` |  |
| ingress.annotations."route.openshift.io/insecureEdgeTerminationPolicy" | string | `"Redirect"` |  |
| ingress.annotations."route.openshift.io/termination" | string | `"edge"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"disco-gateway--fqdn"` |  |
| ingress.hosts[0].paths[0] | string | `"/"` |  |
| keyStoreP12 | string | `"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"` |  |
| keycloak.KEYCLOAK_CLIENT_SECRET | string | `"tr0S6erfHvnZ46KoU1uVuOwGCiA6rfXT"` |  |
| keycloak.enabled | bool | `true` |  |
| keycloakuri | string | `"keycloak"` |  |
| monitoring.application | string | `"gateway"` |  |
| monitoring.domain | string | `"appli"` |  |
| monitoring.environment | string | `"production"` |  |
| monitoring.productName | string | `"disco"` |  |
| monitoring.role | string | `"none"` |  |
| monitoring.topology | string | `"none"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations."prometheus.io/port" | string | `"9000"` |  |
| podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| podAnnotations.metrics | string | `"/actuator/prometheus"` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"200m"` |  |
| resources.limits.memory | string | `"1024Mi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| securityContext | object | `{}` |  |
| service.annotations."prometheus.io/port" | string | `"9000"` |  |
| service.annotations."prometheus.io/scrape" | string | `"true"` |  |
| service.port | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `"ci-cd"` |  |
| services.catalogadmin | string | `"catalog-product-catalog-administration:8080"` |  |
| services.catalogpolicyrule | string | `"catalog-policy-rule:8080"` |  |
| services.catalogui | string | `"catalog-ui:8080"` |  |
| services.category | string | `"catalog-product-category:8080"` |  |
| services.configurator | string | `"product-configurator:8080"` |  |
| services.eventservice | string | `"event-service:8080"` |  |
| services.fallout | string | `"orchestration-delivery-fallout:8080"` |  |
| services.keycloak | string | `"keycloak:80"` |  |
| services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` |  |
| services.offering | string | `"catalog-product-offering:8080"` |  |
| services.offeringprice | string | `"catalog-product-offering-price:8080"` |  |
| services.orchestrationdelivery | string | `"orchestration-delivery:8080"` |  |
| services.orderCapture | string | `"order-capture:8080"` |  |
| services.orderFollowUp | string | `"order-follow-up:8080"` |  |
| services.orderInventory | string | `"order-inventory:8080"` |  |
| services.productcatalog | string | `"catalog-product-catalog:8080"` |  |
| services.productinventory.proxyPath | string | `"productInventory"` |  |
| services.productinventory.serviceName | string | `"product-inventory:8080"` |  |
| services.specification | string | `"catalog-product-specification:8080"` |  |
| services.userroleretrieve | string | `"auth-userrole:8080"` |  |
| tolerations | list | `[]` |  |

Specify each value using the `--set key=value[,key=value]` argument to `helm install`

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml discobole-stable-repo/disco-gateway
```

## Docker image access

These values help you to configure access to the Docker image for this microservice.

- if you need to pull the Docker image from a private or protected registry, you have to create and specify an `imagePullSecret`
- if you wish to let the chart create the image pull secret for you, configure the `serviceAccount.imagePullSecret` section

In case you delegate the creation of an image pull secret, use your own credentials on the private or protected registry, as follows.

```bash
$ helm install my-release discobole-stable-repo/disco-gateway \
--set serviceAccount.imagePullSecret.create=true \
--set serviceAccount.imagePullSecret.registry=<your private or protected docker registry> \
--set serviceAccount.imagePullSecret.username=<you username> \
--set serviceAccount.imagePullSecret.password=<your access token>
```
