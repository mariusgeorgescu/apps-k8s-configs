<!--
SPDX-FileCopyrightText: 2025 Orange SA
SPDX-License-Identifier: MIT

This software is distributed under the MIT License,
the text of which is available at https://opensource.org/license/mit
or see the "LICENSE.txt" file for more details.

Authors: See CONTRIBUTORS.txt
-->

# orchestration-delivery-component

A Helm chart for installing Product Order Delivery Orchestration Component.

**Homepage:** <https://gitlab.ow2.org/discobole>

## Source Code

* <https://gitlab.ow2.org/disco/disco-guide/disco-suite/orchestration-delivery-component>

## Usage

Declare the helm repository:

```bash
helm repo add discobole-stable-repo https://gitlab.ow2.org/api/v4/groups/752345/packages/helm/stable
helm repo update
```

Deploy a release on cluster:

```bash
helm install my-release discobole/orchestration-delivery-component
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
$ helm install my-release discobole/orchestration-delivery-component
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
| autoscaling | object | `{}` |  |
| common.contextPath | string | `""` |  |
| common.dailyshutdown | string | `"enabled"` | daily shutdown |
| common.fluentd.enabled | bool | `false` | set to true to enable fluentd logging |
| common.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| common.fluentd.port | int | `24224` | port of the fluentd instance this application should send logs to. Defaults to localhost |
| common.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| common.imagePullSecrets | list | `[]` | image pull secrets if you use a private registry |
| common.ingress.annotations | string | `nil` | ingress label annotations |
| common.ingress.enabled | bool | `false` |  |
| common.ingress.hosts[0] | object | `{"host":"","paths":["/"]}` | ingress hostnames |
| common.jdkJavaOptions | string | `""` | extra java options to pass to the jvm |
| common.keyStoreP12 | string | `""` | base64 encoded p12 keystore file content |
| common.keycloak.clientId | string | `"${ORCHESTRATION_DELIVERY_KEYCLOAK_CLIENT_ID}"` | Keycloak client ID |
| common.keycloak.clientSecret | string | `"${ORCHESTRATION_DELIVERY_KEYCLOAK_CLIENT_SECRET}"` | Keycloak client secret |
| common.keycloak.enabled | bool | `true` | enable or disable Keycloak integration |
| common.keycloak.uri | string | `"https://keycloak"` | Keycloak service URL (to override) |
| common.monitoring.app | string | `""` | label to specify application name |
| common.monitoring.application | string | `""` | label to specify application name |
| common.monitoring.environment | string | `""` | label for environment being deployed |
| common.monitoring.productName | string | `"discobole"` | label to specify product name      |
| common.od.service.cpib | string | `"product-inventory:8080"` | dependent service |
| common.od.service.kafka | string | `"kafka"` | dependent service |
| common.od.service.mock | string | `"mock-server:8080"` | dependent service |
| common.od.service.poi | string | `"order-inventory:8080"` | dependent service |
| common.od.service.productCatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| common.od.service.userRoleRetrieval | string | `"auth-userrole:8080"` | dependent service |
| common.otel.enabled | bool | `false` | activate Open Telemetry instrumentation |
| common.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| common.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| common.otel.sidecar.otlp | object | `{"host":"","port":4317}` | main receiver address |
| common.podAnnotations | object | `{}` |  |
| common.registryCredentials.create | bool | `false` | specifies whether a registry credentials secret should be created |
| common.registryCredentials.token.password | string | `""` |  |
| common.registryCredentials.token.userName | string | `""` |  |
| common.registryCredentials.url | string | `""` |  |
| common.replicaCount | int | `1` | application replica count |
| common.service.annotations | object | `{}` | enable monitoring and supervision of service |
| common.service.port | int | `8080` | service port |
| common.service.type | string | `"ClusterIP"` | service type |
| fullnameOverride | string | `""` |  |
| image | object | `{}` |  |
| imagePullSecrets | list | `[]` |  |
| ingress | object | `{}` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| orchestration-delivery-fallout.<<.contextPath | string | `""` |  |
| orchestration-delivery-fallout.<<.dailyshutdown | string | `"enabled"` | daily shutdown |
| orchestration-delivery-fallout.<<.fluentd.enabled | bool | `false` | set to true to enable fluentd logging |
| orchestration-delivery-fallout.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| orchestration-delivery-fallout.<<.fluentd.port | int | `24224` | port of the fluentd instance this application should send logs to. Defaults to localhost |
| orchestration-delivery-fallout.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| orchestration-delivery-fallout.<<.imagePullSecrets | list | `[]` | image pull secrets if you use a private registry |
| orchestration-delivery-fallout.<<.ingress.annotations | string | `nil` | ingress label annotations |
| orchestration-delivery-fallout.<<.ingress.enabled | bool | `false` |  |
| orchestration-delivery-fallout.<<.ingress.hosts[0] | object | `{"host":"","paths":["/"]}` | ingress hostnames |
| orchestration-delivery-fallout.<<.jdkJavaOptions | string | `""` | extra java options to pass to the jvm |
| orchestration-delivery-fallout.<<.keyStoreP12 | string | `""` | base64 encoded p12 keystore file content |
| orchestration-delivery-fallout.<<.keycloak.clientId | string | `"${ORCHESTRATION_DELIVERY_KEYCLOAK_CLIENT_ID}"` | Keycloak client ID |
| orchestration-delivery-fallout.<<.keycloak.clientSecret | string | `"${ORCHESTRATION_DELIVERY_KEYCLOAK_CLIENT_SECRET}"` | Keycloak client secret |
| orchestration-delivery-fallout.<<.keycloak.enabled | bool | `true` | enable or disable Keycloak integration |
| orchestration-delivery-fallout.<<.keycloak.uri | string | `"https://keycloak"` | Keycloak service URL (to override) |
| orchestration-delivery-fallout.<<.monitoring.app | string | `""` | label to specify application name |
| orchestration-delivery-fallout.<<.monitoring.application | string | `""` | label to specify application name |
| orchestration-delivery-fallout.<<.monitoring.environment | string | `""` | label for environment being deployed |
| orchestration-delivery-fallout.<<.monitoring.productName | string | `"discobole"` | label to specify product name      |
| orchestration-delivery-fallout.<<.od.service.cpib | string | `"product-inventory:8080"` | dependent service |
| orchestration-delivery-fallout.<<.od.service.kafka | string | `"kafka"` | dependent service |
| orchestration-delivery-fallout.<<.od.service.mock | string | `"mock-server:8080"` | dependent service |
| orchestration-delivery-fallout.<<.od.service.poi | string | `"order-inventory:8080"` | dependent service |
| orchestration-delivery-fallout.<<.od.service.productCatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| orchestration-delivery-fallout.<<.od.service.userRoleRetrieval | string | `"auth-userrole:8080"` | dependent service |
| orchestration-delivery-fallout.<<.otel.enabled | bool | `false` | activate Open Telemetry instrumentation |
| orchestration-delivery-fallout.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| orchestration-delivery-fallout.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| orchestration-delivery-fallout.<<.otel.sidecar.otlp | object | `{"host":"","port":4317}` | main receiver address |
| orchestration-delivery-fallout.<<.podAnnotations | object | `{}` |  |
| orchestration-delivery-fallout.<<.registryCredentials.create | bool | `false` | specifies whether a registry credentials secret should be created |
| orchestration-delivery-fallout.<<.registryCredentials.token.password | string | `""` |  |
| orchestration-delivery-fallout.<<.registryCredentials.token.userName | string | `""` |  |
| orchestration-delivery-fallout.<<.registryCredentials.url | string | `""` |  |
| orchestration-delivery-fallout.<<.replicaCount | int | `1` | application replica count |
| orchestration-delivery-fallout.<<.service.annotations | object | `{}` | enable monitoring and supervision of service |
| orchestration-delivery-fallout.<<.service.port | int | `8080` | service port |
| orchestration-delivery-fallout.<<.service.type | string | `"ClusterIP"` | service type |
| orchestration-delivery-fallout.fluentd.tag | string | `"orchestration-delivery-fallout"` |  |
| orchestration-delivery-fallout.mongo.arbiter.enabled | bool | `false` |  |
| orchestration-delivery-fallout.mongo.architecture | string | `"replicaset"` |  |
| orchestration-delivery-fallout.mongo.auth.enabled | bool | `false` |  |
| orchestration-delivery-fallout.mongo.auth.rootPassword | string | `"$ORCHESTRATION_DELIVERY_FALLOUT_MONGO_PASSWORD"` |  |
| orchestration-delivery-fallout.mongo.auth.rootUser | string | `"mongo_user"` |  |
| orchestration-delivery-fallout.mongo.directoryPerDB | bool | `true` |  |
| orchestration-delivery-fallout.mongo.enabled | bool | `true` |  |
| orchestration-delivery-fallout.mongo.extraEnvVarsSecret | string | `"orchestration-delivery-fallout-mongo-secret"` |  |
| orchestration-delivery-fallout.mongo.fullnameOverride | string | `"delivery-fallout-mongo"` |  |
| orchestration-delivery-fallout.mongo.global.imageRegistry | string | `"registry.hub.docker.com"` |  |
| orchestration-delivery-fallout.mongo.global.storageClass | string | `"block-default-storage-class"` |  |
| orchestration-delivery-fallout.mongo.image.repository | string | `"bitnamilegacy/mongodb"` |  |
| orchestration-delivery-fallout.mongo.initdbScripts."init.js" | string | `"// app user\ndb.getSiblingDB(\"orchestration_delivery_fallout\")\nuse orchestration_delivery_fallout;\ndb.createCollection(\"dummy_table\")\ndb.dummy_table.insertOne({\"desc\" : \"creare dummy row to create database\"})        \nvar username='mongo_user';\nvar password=process.env[\"MONGO_DB_PWD\"];\nvar user=db.getUser(username);\nif (user == null) {\n  print('create user: ' + username);\n  db.createUser({user: 'mongo_user',pwd: password,roles: [ { role: 'readWrite', db: 'orchestration_delivery_fallout' }, { role: 'readWrite', db: 'catalog' } ]});\n} else {\n  print('update user: ' + username);\n  db.updateUser(username, {pwd: password});\n}\nprint('---- done for ' + username);\nquit(0);\n"` |  |
| orchestration-delivery-fallout.mongo.metrics.enabled | bool | `true` |  |
| orchestration-delivery-fallout.mongo.metrics.image.repository | string | `"bitnamilegacy/mongodb-exporter"` |  |
| orchestration-delivery-fallout.mongo.replicaCount | int | `1` |  |
| orchestration-delivery-fallout.mongo.resources.limits.memory | string | `"1500Mi"` |  |
| orchestration-delivery-fallout.mongo.service.nameOverride | string | `"orchestration-delivery-fallout-mongo"` |  |
| orchestration-delivery-fallout.mongo.service.ports.mongodb | int | `27017` |  |
| orchestration-delivery-fallout.mongo.useStatefulSet | bool | `true` |  |
| orchestration-delivery-fallout.monitoring.app | string | `"orchestration-delivery-fallout"` |  |
| orchestration-delivery-fallout.monitoring.application | string | `"orchestration-delivery-fallout"` |  |
| orchestration-delivery-fallout.som_mock_job_cron_expression | string | `"0/30 * * * * *"` |  |
| orchestration-delivery-management.<<.contextPath | string | `""` |  |
| orchestration-delivery-management.<<.dailyshutdown | string | `"enabled"` | daily shutdown |
| orchestration-delivery-management.<<.fluentd.enabled | bool | `false` | set to true to enable fluentd logging |
| orchestration-delivery-management.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| orchestration-delivery-management.<<.fluentd.port | int | `24224` | port of the fluentd instance this application should send logs to. Defaults to localhost |
| orchestration-delivery-management.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| orchestration-delivery-management.<<.imagePullSecrets | list | `[]` | image pull secrets if you use a private registry |
| orchestration-delivery-management.<<.ingress.annotations | string | `nil` | ingress label annotations |
| orchestration-delivery-management.<<.ingress.enabled | bool | `false` |  |
| orchestration-delivery-management.<<.ingress.hosts[0] | object | `{"host":"","paths":["/"]}` | ingress hostnames |
| orchestration-delivery-management.<<.jdkJavaOptions | string | `""` | extra java options to pass to the jvm |
| orchestration-delivery-management.<<.keyStoreP12 | string | `""` | base64 encoded p12 keystore file content |
| orchestration-delivery-management.<<.keycloak.clientId | string | `"${ORCHESTRATION_DELIVERY_KEYCLOAK_CLIENT_ID}"` | Keycloak client ID |
| orchestration-delivery-management.<<.keycloak.clientSecret | string | `"${ORCHESTRATION_DELIVERY_KEYCLOAK_CLIENT_SECRET}"` | Keycloak client secret |
| orchestration-delivery-management.<<.keycloak.enabled | bool | `true` | enable or disable Keycloak integration |
| orchestration-delivery-management.<<.keycloak.uri | string | `"https://keycloak"` | Keycloak service URL (to override) |
| orchestration-delivery-management.<<.monitoring.app | string | `""` | label to specify application name |
| orchestration-delivery-management.<<.monitoring.application | string | `""` | label to specify application name |
| orchestration-delivery-management.<<.monitoring.environment | string | `""` | label for environment being deployed |
| orchestration-delivery-management.<<.monitoring.productName | string | `"discobole"` | label to specify product name      |
| orchestration-delivery-management.<<.od.service.cpib | string | `"product-inventory:8080"` | dependent service |
| orchestration-delivery-management.<<.od.service.kafka | string | `"kafka"` | dependent service |
| orchestration-delivery-management.<<.od.service.mock | string | `"mock-server:8080"` | dependent service |
| orchestration-delivery-management.<<.od.service.poi | string | `"order-inventory:8080"` | dependent service |
| orchestration-delivery-management.<<.od.service.productCatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| orchestration-delivery-management.<<.od.service.userRoleRetrieval | string | `"auth-userrole:8080"` | dependent service |
| orchestration-delivery-management.<<.otel.enabled | bool | `false` | activate Open Telemetry instrumentation |
| orchestration-delivery-management.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| orchestration-delivery-management.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| orchestration-delivery-management.<<.otel.sidecar.otlp | object | `{"host":"","port":4317}` | main receiver address |
| orchestration-delivery-management.<<.podAnnotations | object | `{}` |  |
| orchestration-delivery-management.<<.registryCredentials.create | bool | `false` | specifies whether a registry credentials secret should be created |
| orchestration-delivery-management.<<.registryCredentials.token.password | string | `""` |  |
| orchestration-delivery-management.<<.registryCredentials.token.userName | string | `""` |  |
| orchestration-delivery-management.<<.registryCredentials.url | string | `""` |  |
| orchestration-delivery-management.<<.replicaCount | int | `1` | application replica count |
| orchestration-delivery-management.<<.service.annotations | object | `{}` | enable monitoring and supervision of service |
| orchestration-delivery-management.<<.service.port | int | `8080` | service port |
| orchestration-delivery-management.<<.service.type | string | `"ClusterIP"` | service type |
| orchestration-delivery-management.fluentd.tag | string | `"orchestration-delivery-management"` |  |
| orchestration-delivery-management.monitoring.app | string | `"orchestration-delivery-management"` |  |
| orchestration-delivery-management.monitoring.application | string | `"orchestration-delivery-management"` |  |
| orchestration-delivery-management.od.service.spring_json_secret_name | string | `"orchestration-delivery-spring"` |  |
| orchestration-delivery-management.od.spring_json_secret_name | string | `"orchestration-delivery-spring"` |  |
| orchestration-delivery.<<.contextPath | string | `""` |  |
| orchestration-delivery.<<.dailyshutdown | string | `"enabled"` | daily shutdown |
| orchestration-delivery.<<.fluentd.enabled | bool | `false` | set to true to enable fluentd logging |
| orchestration-delivery.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| orchestration-delivery.<<.fluentd.port | int | `24224` | port of the fluentd instance this application should send logs to. Defaults to localhost |
| orchestration-delivery.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| orchestration-delivery.<<.imagePullSecrets | list | `[]` | image pull secrets if you use a private registry |
| orchestration-delivery.<<.ingress.annotations | string | `nil` | ingress label annotations |
| orchestration-delivery.<<.ingress.enabled | bool | `false` |  |
| orchestration-delivery.<<.ingress.hosts[0] | object | `{"host":"","paths":["/"]}` | ingress hostnames |
| orchestration-delivery.<<.jdkJavaOptions | string | `""` | extra java options to pass to the jvm |
| orchestration-delivery.<<.keyStoreP12 | string | `""` | base64 encoded p12 keystore file content |
| orchestration-delivery.<<.keycloak.clientId | string | `"${ORCHESTRATION_DELIVERY_KEYCLOAK_CLIENT_ID}"` | Keycloak client ID |
| orchestration-delivery.<<.keycloak.clientSecret | string | `"${ORCHESTRATION_DELIVERY_KEYCLOAK_CLIENT_SECRET}"` | Keycloak client secret |
| orchestration-delivery.<<.keycloak.enabled | bool | `true` | enable or disable Keycloak integration |
| orchestration-delivery.<<.keycloak.uri | string | `"https://keycloak"` | Keycloak service URL (to override) |
| orchestration-delivery.<<.monitoring.app | string | `""` | label to specify application name |
| orchestration-delivery.<<.monitoring.application | string | `""` | label to specify application name |
| orchestration-delivery.<<.monitoring.environment | string | `""` | label for environment being deployed |
| orchestration-delivery.<<.monitoring.productName | string | `"discobole"` | label to specify product name      |
| orchestration-delivery.<<.od.service.cpib | string | `"product-inventory:8080"` | dependent service |
| orchestration-delivery.<<.od.service.kafka | string | `"kafka"` | dependent service |
| orchestration-delivery.<<.od.service.mock | string | `"mock-server:8080"` | dependent service |
| orchestration-delivery.<<.od.service.poi | string | `"order-inventory:8080"` | dependent service |
| orchestration-delivery.<<.od.service.productCatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| orchestration-delivery.<<.od.service.userRoleRetrieval | string | `"auth-userrole:8080"` | dependent service |
| orchestration-delivery.<<.otel.enabled | bool | `false` | activate Open Telemetry instrumentation |
| orchestration-delivery.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| orchestration-delivery.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| orchestration-delivery.<<.otel.sidecar.otlp | object | `{"host":"","port":4317}` | main receiver address |
| orchestration-delivery.<<.podAnnotations | object | `{}` |  |
| orchestration-delivery.<<.registryCredentials.create | bool | `false` | specifies whether a registry credentials secret should be created |
| orchestration-delivery.<<.registryCredentials.token.password | string | `""` |  |
| orchestration-delivery.<<.registryCredentials.token.userName | string | `""` |  |
| orchestration-delivery.<<.registryCredentials.url | string | `""` |  |
| orchestration-delivery.<<.replicaCount | int | `1` | application replica count |
| orchestration-delivery.<<.service.annotations | object | `{}` | enable monitoring and supervision of service |
| orchestration-delivery.<<.service.port | int | `8080` | service port |
| orchestration-delivery.<<.service.type | string | `"ClusterIP"` | service type |
| orchestration-delivery.fluentd.tag | string | `"orchestration-delivery"` |  |
| orchestration-delivery.mongo.arbiter.enabled | bool | `false` |  |
| orchestration-delivery.mongo.architecture | string | `"replicaset"` |  |
| orchestration-delivery.mongo.auth.enabled | bool | `false` |  |
| orchestration-delivery.mongo.auth.rootPassword | string | `"$ORCHESTRATION_DELIVERY_MONGO_PASSWORD"` |  |
| orchestration-delivery.mongo.auth.rootUser | string | `"mongo_user"` |  |
| orchestration-delivery.mongo.directoryPerDB | bool | `true` |  |
| orchestration-delivery.mongo.enabled | bool | `true` |  |
| orchestration-delivery.mongo.extraEnvVarsSecret | string | `"orchestration-delivery-mongo-secret"` |  |
| orchestration-delivery.mongo.fullnameOverride | string | `"orchestration-delivery-mongo"` |  |
| orchestration-delivery.mongo.global.imageRegistry | string | `"registry.hub.docker.com"` |  |
| orchestration-delivery.mongo.global.storageClass | string | `"block-default-storage-class"` |  |
| orchestration-delivery.mongo.image.repository | string | `"bitnamilegacy/mongodb"` |  |
| orchestration-delivery.mongo.initdbScripts."init.js" | string | `"// app user\ndb.getSiblingDB(\"orchestration_delivery\")\nuse orchestration_delivery;\ndb.createCollection(\"dummy_table\")\ndb.dummy_table.insertOne({\"desc\" : \"creare dummy row to create database\"})\nvar username='mongo_user';\nvar password=process.env[\"MONGO_DB_PWD\"];\nvar user=db.getUser(username);\nif (user == null) {\n  print('create user: ' + username);\n  db.createUser({user: 'mongo_user',pwd: password,roles: [ { role: 'readWrite', db: 'orchestration_delivery' }, { role: 'readWrite', db: 'catalog' } ]});\n} else {\n  print('update user: ' + username);\n  db.updateUser(username, {pwd: password});\n}\nprint('---- done for ' + username);\nquit(0);\n"` |  |
| orchestration-delivery.mongo.metrics.enabled | bool | `true` |  |
| orchestration-delivery.mongo.metrics.image.repository | string | `"bitnamilegacy/mongodb-exporter"` |  |
| orchestration-delivery.mongo.replicaCount | int | `1` |  |
| orchestration-delivery.mongo.resources.limits.memory | string | `"1500Mi"` |  |
| orchestration-delivery.mongo.service.nameOverride | string | `"orchestration-delivery-mongo"` |  |
| orchestration-delivery.mongo.service.ports.mongodb | int | `27017` |  |
| orchestration-delivery.mongo.useStatefulSet | bool | `true` |  |
| orchestration-delivery.monitoring.app | string | `"orchestration-delivery"` |  |
| orchestration-delivery.monitoring.application | string | `"orchestration-delivery"` |  |
| orchestration-delivery.od.service.fallout | string | `"orchestration-delivery-fallout:8080"` |  |
| orchestration-delivery.plan.deletePlanThresholdDuration | string | `"P0DT0H10M"` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount | object | `{}` |  |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |

Specify each value using the `--set key=value[,key=value]` argument to `helm install`

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml discobole/orchestration-delivery-component
```

## Docker image access

These values help you to configure access to the Docker image for this microservice.

- if you need to pull the Docker image from a private or protected registry, you have to create and specify an `imagePullSecret`
- if you wish to let the chart create the image pull secret for you, configure the `serviceAccount.imagePullSecret` section

In case you delegate the creation of an image pull secret, use your own credentials on the private or protected registry, as follows.

```bash
$ helm install my-release discobole/orchestration-delivery-component \
--set serviceAccount.imagePullSecret.create=true \
--set serviceAccount.imagePullSecret.registry=<your private or protected docker registry> \
--set serviceAccount.imagePullSecret.username=<you username> \
--set serviceAccount.imagePullSecret.password=<your access token>
```
