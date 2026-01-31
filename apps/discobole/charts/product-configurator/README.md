# product-configurator

A Helm chart for Kubernetes

## Source Code

* <https://gitlab.ow2.org/discobole/product-configurator/qualification/>

## Usage

Declare the helm repository:

```bash
helm repo add discobole-stable-repo https://gitlab.ow2.org/api/v4/groups/752345/packages/helm/stable
helm repo update
```

Deploy a release on cluster:

```bash
helm install my-release disco-stable-repo/product-configurator
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
$ helm install my-release disco-stable-repo/product-configurator
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
| DISCO_DEV_CATALOG_MONGO_PASSWORD | string | `"sD0dMMw82AlkJUQjobn44aGviFC6nDO"` |  |
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `5` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| contextPath | string | `""` |  |
| dailyshutdown | string | `"enabled"` |  |
| database.enabled | bool | `true` |  |
| database.rootPassword | string | `"sD0dMMw82AlkJUQjobn44aGviFC6nDO"` |  |
| database.rootUser | string | `"mongo_user"` |  |
| fluentd.enabled | bool | `true` |  |
| fluentd.host | string | `"apps-fluentd"` |  |
| fluentd.tag | string | `"product-configurator"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"registry.gitlab.tech.orange/disco/disco-oda-components/disco-product-configurator/product-configurator/snapshot"` |  |
| image.tag | string | `"1-7-0"` |  |
| imagePullSecrets[0].name | string | `"discoregistry-imagepuller"` |  |
| imagePullSecrets[1].name | string | `"default-dockercfg-b7fws"` |  |
| ingress.annotations."route.openshift.io/insecureEdgeTerminationPolicy" | string | `"Redirect"` |  |
| ingress.annotations."route.openshift.io/termination" | string | `"edge"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"-fqdn"` |  |
| ingress.hosts[0].paths[0] | string | `"/"` |  |
| keyStoreP12 | string | `"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"` |  |
| monitoring.application | string | `"product-configurator"` |  |
| monitoring.environment | string | `""` |  |
| monitoring.productName | string | `"disco"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| otel.attributes.cluster | string | `"diod-openshift"` |  |
| otel.attributes.hostname | string | `""` |  |
| otel.attributes.namespace | string | `"disco-production"` |  |
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
| promtail.config | object | See `values.yaml` | Section for crafting Promtails config file. The only directly relevant value is `config.file` which is a templated string that references the other values and snippets below this key. |
| promtail.config.file | string | See `values.yaml` | Config file contents for Promtail. Must be configured as string. It is templated so it can be assembled from reusable snippets in order to avoid redundancy. |
| promtail.config.logLevel | string | `""` | The log level of the Promtail server Must be reference in `config.file` to configure `server.log_level` See default config in `values.yaml` |
| promtail.config.lokiAddress | string | `""` | The Loki address to post logs to. Must be reference in `config.file` to configure `client.url`. See default config in `values.yaml` |
| promtail.config.snippets | object | See `values.yaml` | A section of reusable snippets that can be reference in `config.file`. Custom snippets may be added in order to reduce redundancy. This is especially helpful when multiple `kubernetes_sd_configs` are use which usually have large parts in common. |
| promtail.config.snippets.extraClientConfigs | string | empty | You can put here any keys that will be directly added to the config file's 'client' block. |
| promtail.config.snippets.extraRelabelConfigs | list | `[]` | You can put here any additional relabel_configs to "kubernetes-pods" job |
| promtail.config.snippets.extraScrapeConfigs | string | empty | You can put here any additional scrape configs you want to add to the config file. |
| promtail.enabled | bool | `false` |  |
| promtail.extraArgs | list | `[]` |  |
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
| services.catalogui | string | `"catalog-ui:80"` |  |
| services.category | string | `"catalog-product-category:8080"` |  |
| services.configurator | string | `"product-configurator:8080"` |  |
| services.cpib | string | `"product-inventory:8080"` |  |
| services.dbname | string | `"catalog"` |  |
| services.gateway | string | `"disco-gateway:8080"` |  |
| services.kafka | string | `"kafka:9092"` |  |
| services.keycloak | string | `"keycloak:80"` |  |
| services.keycloakrealm | string | `"SpringBootKeycloak"` |  |
| services.keycloakroute | string | `"keycloak"` |  |
| services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` |  |
| services.mockservice | string | `"mock-service:80"` |  |
| services.mongodb | string | `"catalog-mongo"` |  |
| services.offering | string | `"catalog-product-offering:8080"` |  |
| services.offeringprice | string | `"catalog-product-offering-price:8080"` |  |
| services.policyrule | string | `"catalog-policy-rule:8080"` |  |
| services.productcatalog | string | `"catalog-product-catalog:8080"` |  |
| services.specification | string | `"catalog-product-specification:8080"` |  |
| services.userroleretrieve | string | `"auth-userrole:8080"` |  |
| tolerations | list | `[]` |  |

Specify each value using the `--set key=value[,key=value]` argument to `helm install`

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml disco-stable-repo/product-configurator
```

## Docker image access

These values help you to configure access to the Docker image for this microservice.

- if you need to pull the Docker image from a private or protected registry, you have to create and specify an `imagePullSecret`
- if you wish to let the chart create the image pull secret for you, configure the `serviceAccount.imagePullSecret` section

In case you delegate the creation of an image pull secret, use your own credentials on the private or protected registry, as follows.

```bash
$ helm install my-release disco-stable-repo/product-configurator \
--set serviceAccount.imagePullSecret.create=true \
--set serviceAccount.imagePullSecret.registry=<your private or protected docker registry> \
--set serviceAccount.imagePullSecret.username=<you username> \
--set serviceAccount.imagePullSecret.password=<your access token>
```
