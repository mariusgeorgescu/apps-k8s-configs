<!--
SPDX-FileCopyrightText: 2025 Orange SA
SPDX-License-Identifier: MIT

This software is distributed under the MIT License,
the text of which is available at https://opensource.org/license/mit
or see the "LICENSE.txt" file for more details.

Authors: See CONTRIBUTORS.txt
-->

# catalog-component

A Helm chart for installing Product Catalog Component.

**Homepage:** <https://gitlab.ow2.org/discobole>

## Source Code

* <https://gitlab.ow2.org/disco/disco-guide/disco-suite/catalog-component>

## Usage

Declare the helm repository:

```bash
helm repo add discobole-stable-repo https://gitlab.ow2.org/api/v4/groups/752345/packages/helm/stable
helm repo update
```

Deploy a release on cluster:

```bash
helm install my-release discobole/catalog-component
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
$ helm install my-release discobole/catalog-component
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
| catalog-event-service.dailyshutdown | string | `"enabled"` | enable or disable application daily shutdown |
| catalog-event-service.enabled | bool | `true` | set to false if you don't wish this chart to install this service |
| catalog-event-service.imagePullSecrets | list | `[]` | specify pulling image secrets if your image repository requires it |
| catalog-event-service.ingress.annotations | string | `nil` | ingress annotations |
| catalog-event-service.ingress.enabled | bool | `false` | enable ingress controller |
| catalog-event-service.ingress.hosts[0] | object | `{"host":"","paths":["/"]}` | host names for the ingress controller |
| catalog-event-service.monitoring.application | string | `"catalog-event-service"` | label to specify application monitoring |
| catalog-event-service.monitoring.domain | string | `""` |  |
| catalog-event-service.monitoring.environment | string | `""` | label for environment being deployed |
| catalog-event-service.monitoring.productName | string | `"discobole"` | label to specify product name (chart name by default) |
| catalog-event-service.monitoring.role | string | `""` | label to specify role |
| catalog-event-service.monitoring.topology | string | `""` | label to specify topology |
| catalog-event-service.podAnnotations | object | `{}` |  |
| catalog-event-service.replicaCount | int | `1` | application replica count |
| catalog-event-service.resources.limits | object | `{"cpu":"200m","memory":"512Mi"}` | resource limits |
| catalog-event-service.resources.requests | object | `{"cpu":"100m","memory":"128Mi"}` | resource requests     |
| catalog-event-service.service | object | `{"annotations":null,"port":8080,"type":"ClusterIP"}` | enable monitoring and supervision of pods prometheus.io/port: '9000' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' |
| catalog-event-service.service.annotations | string | `nil` | enable monitoring and supervision of service |
| catalog-event-service.service.port | int | `8080` | service port |
| catalog-event-service.service.type | string | `"ClusterIP"` | service type |
| catalog-event-service.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| catalog-event-service.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| catalog-event-service.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| catalog-event-service.services.kafka | string | `"kafka:9092"` | dependent service |
| catalog-event-service.services.keycloak | string | `"keycloak:80"` | dependent service |
| catalog-event-service.services.keycloakrealm | string | `"SpringBootKeycloak"` | keycloak realm |
| catalog-event-service.services.keycloakroute | string | `"keycloak"` | dependent service |
| catalog-event-service.services.userroleretrieve | string | `"auth-userrole:8080"` | dependent service |
| catalog-policy-rule.<<.contextPath | string | `""` | context path of the application |
| catalog-policy-rule.<<.dailyshutdown | string | `"enabled"` | enable or disable application daily shutdown |
| catalog-policy-rule.<<.database.enabled | bool | `true` | enable database creation |
| catalog-policy-rule.<<.database.rootPassword | string | `"${CATALOG_MONGO_PASSWORD}"` | database root password |
| catalog-policy-rule.<<.database.rootUser | string | `"mongo_user"` | database root user |
| catalog-policy-rule.<<.fluentd.enabled | bool | `false` | enable fluentd sidecar container |
| catalog-policy-rule.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| catalog-policy-rule.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| catalog-policy-rule.<<.imagePullSecrets | list | `[]` | specify pulling image secrets if your image repository requires it |
| catalog-policy-rule.<<.ingress.annotations | object | `{}` | ingress annotations |
| catalog-policy-rule.<<.ingress.enabled | bool | `false` | enable ingress controller |
| catalog-policy-rule.<<.ingress.hosts[0].host | string | `""` |  |
| catalog-policy-rule.<<.ingress.hosts[0].paths[0] | string | `"/"` |  |
| catalog-policy-rule.<<.keyStoreP12 | string | `""` | keystore in P12 format, base64 encoded |
| catalog-policy-rule.<<.keycloak.enabled | bool | `false` | enable keycloak authentication |
| catalog-policy-rule.<<.keycloak.issuerURI | string | `"https://keycloak/realms/SpringBootKeycloak"` | keycloak issuer URI (to override) |
| catalog-policy-rule.<<.monitoring.application | string | `""` | label to specify application monitoring |
| catalog-policy-rule.<<.monitoring.domain | string | `""` |  |
| catalog-policy-rule.<<.monitoring.environment | string | `""` | label for environment being deployed |
| catalog-policy-rule.<<.monitoring.productName | string | `"discobole"` | label to specify product name (chart name by default) |
| catalog-policy-rule.<<.monitoring.role | string | `""` | label to specify role |
| catalog-policy-rule.<<.monitoring.topology | string | `""` | label to specify topology |
| catalog-policy-rule.<<.otel.attributes.cluster | string | `""` | resource attribute to be set on telemetry data |
| catalog-policy-rule.<<.otel.attributes.hostname | string | `""` | resource attribute to be set on telemetry data |
| catalog-policy-rule.<<.otel.attributes.namespace | string | `""` | resource attribute to be set on telemetry data |
| catalog-policy-rule.<<.otel.attributes.platform | string | `""` | resource attribute to be set on telemetry data |
| catalog-policy-rule.<<.otel.attributes.region | string | `""` | resource attribute to be set on telemetry data |
| catalog-policy-rule.<<.otel.enabled | bool | `false` |  |
| catalog-policy-rule.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| catalog-policy-rule.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| catalog-policy-rule.<<.otel.sidecar.otlp | object | `{"host":null,"port":4317}` | main receiver address |
| catalog-policy-rule.<<.podAnnotations | object | `{}` |  |
| catalog-policy-rule.<<.replicaCount | int | `1` | application replica count |
| catalog-policy-rule.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| catalog-policy-rule.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| catalog-policy-rule.<<.service | object | `{"annotations":{},"port":8080,"type":"ClusterIP"}` | enable monitoring and supervision of pods prometheus.io/port: '9000' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' |
| catalog-policy-rule.<<.service.annotations | object | `{}` | enable monitoring and supervision of service     |
| catalog-policy-rule.<<.service.port | int | `8080` | service port  |
| catalog-policy-rule.<<.service.type | string | `"ClusterIP"` | service type |
| catalog-policy-rule.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| catalog-policy-rule.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| catalog-policy-rule.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| catalog-policy-rule.<<.services.catalogui | string | `"catalog-ui:80"` | dependent service |
| catalog-policy-rule.<<.services.category | string | `"catalog-product-category:8080"` | dependent service |
| catalog-policy-rule.<<.services.dbname | string | `"catalog"` | mongo database name |
| catalog-policy-rule.<<.services.gateway | string | `"disco-gateway:8080"` | dependent service |
| catalog-policy-rule.<<.services.kafka | string | `"kafka:9092"` | dependent service |
| catalog-policy-rule.<<.services.keycloak | string | `"keycloak:80"` | dependent service |
| catalog-policy-rule.<<.services.keycloakrealm | string | `"SpringBootKeycloak"` | keycloak realm |
| catalog-policy-rule.<<.services.keycloakroute | string | `"keycloak"` | dependent service |
| catalog-policy-rule.<<.services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` | dependent service |
| catalog-policy-rule.<<.services.mockservice | string | `"mock-service:80"` | dependent service |
| catalog-policy-rule.<<.services.mongodb | string | `"catalog-mongo"` | hostnames and ports of dependent services |
| catalog-policy-rule.<<.services.offering | string | `"catalog-product-offering:8080"` | dependent service |
| catalog-policy-rule.<<.services.offeringprice | string | `"catalog-product-offering-price:8080"` | dependent service |
| catalog-policy-rule.<<.services.productcatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| catalog-policy-rule.<<.services.specification | string | `"catalog-product-specification:8080"` | dependent service |
| catalog-policy-rule.<<.services.userroleretrieve | string | `"auth-userrole:8080"` | dependent service |
| catalog-policy-rule.fluentd.tag | string | `"catalog-policy-rule"` |  |
| catalog-policy-rule.monitoring.application | string | `"catalog-policy-rule"` |  |
| catalog-policy-rule.services.catprodcaturl | string | `"https://catalog-product-catalog"` | catalog API URL |
| catalog-product-catalog-administration.<<.contextPath | string | `""` | context path of the application |
| catalog-product-catalog-administration.<<.dailyshutdown | string | `"enabled"` | enable or disable application daily shutdown |
| catalog-product-catalog-administration.<<.database.enabled | bool | `true` | enable database creation |
| catalog-product-catalog-administration.<<.database.rootPassword | string | `"${CATALOG_MONGO_PASSWORD}"` | database root password |
| catalog-product-catalog-administration.<<.database.rootUser | string | `"mongo_user"` | database root user |
| catalog-product-catalog-administration.<<.fluentd.enabled | bool | `false` | enable fluentd sidecar container |
| catalog-product-catalog-administration.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| catalog-product-catalog-administration.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| catalog-product-catalog-administration.<<.imagePullSecrets | list | `[]` | specify pulling image secrets if your image repository requires it |
| catalog-product-catalog-administration.<<.ingress.annotations | object | `{}` | ingress annotations |
| catalog-product-catalog-administration.<<.ingress.enabled | bool | `false` | enable ingress controller |
| catalog-product-catalog-administration.<<.ingress.hosts[0].host | string | `""` |  |
| catalog-product-catalog-administration.<<.ingress.hosts[0].paths[0] | string | `"/"` |  |
| catalog-product-catalog-administration.<<.keyStoreP12 | string | `""` | keystore in P12 format, base64 encoded |
| catalog-product-catalog-administration.<<.keycloak.enabled | bool | `false` | enable keycloak authentication |
| catalog-product-catalog-administration.<<.keycloak.issuerURI | string | `"https://keycloak/realms/SpringBootKeycloak"` | keycloak issuer URI (to override) |
| catalog-product-catalog-administration.<<.monitoring.application | string | `""` | label to specify application monitoring |
| catalog-product-catalog-administration.<<.monitoring.domain | string | `""` |  |
| catalog-product-catalog-administration.<<.monitoring.environment | string | `""` | label for environment being deployed |
| catalog-product-catalog-administration.<<.monitoring.productName | string | `"discobole"` | label to specify product name (chart name by default) |
| catalog-product-catalog-administration.<<.monitoring.role | string | `""` | label to specify role |
| catalog-product-catalog-administration.<<.monitoring.topology | string | `""` | label to specify topology |
| catalog-product-catalog-administration.<<.otel.attributes.cluster | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-catalog-administration.<<.otel.attributes.hostname | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-catalog-administration.<<.otel.attributes.namespace | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-catalog-administration.<<.otel.attributes.platform | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-catalog-administration.<<.otel.attributes.region | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-catalog-administration.<<.otel.enabled | bool | `false` |  |
| catalog-product-catalog-administration.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| catalog-product-catalog-administration.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| catalog-product-catalog-administration.<<.otel.sidecar.otlp | object | `{"host":null,"port":4317}` | main receiver address |
| catalog-product-catalog-administration.<<.podAnnotations | object | `{}` |  |
| catalog-product-catalog-administration.<<.replicaCount | int | `1` | application replica count |
| catalog-product-catalog-administration.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| catalog-product-catalog-administration.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| catalog-product-catalog-administration.<<.service | object | `{"annotations":{},"port":8080,"type":"ClusterIP"}` | enable monitoring and supervision of pods prometheus.io/port: '9000' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' |
| catalog-product-catalog-administration.<<.service.annotations | object | `{}` | enable monitoring and supervision of service     |
| catalog-product-catalog-administration.<<.service.port | int | `8080` | service port  |
| catalog-product-catalog-administration.<<.service.type | string | `"ClusterIP"` | service type |
| catalog-product-catalog-administration.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| catalog-product-catalog-administration.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| catalog-product-catalog-administration.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| catalog-product-catalog-administration.<<.services.catalogui | string | `"catalog-ui:80"` | dependent service |
| catalog-product-catalog-administration.<<.services.category | string | `"catalog-product-category:8080"` | dependent service |
| catalog-product-catalog-administration.<<.services.dbname | string | `"catalog"` | mongo database name |
| catalog-product-catalog-administration.<<.services.gateway | string | `"disco-gateway:8080"` | dependent service |
| catalog-product-catalog-administration.<<.services.kafka | string | `"kafka:9092"` | dependent service |
| catalog-product-catalog-administration.<<.services.keycloak | string | `"keycloak:80"` | dependent service |
| catalog-product-catalog-administration.<<.services.keycloakrealm | string | `"SpringBootKeycloak"` | keycloak realm |
| catalog-product-catalog-administration.<<.services.keycloakroute | string | `"keycloak"` | dependent service |
| catalog-product-catalog-administration.<<.services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` | dependent service |
| catalog-product-catalog-administration.<<.services.mockservice | string | `"mock-service:80"` | dependent service |
| catalog-product-catalog-administration.<<.services.mongodb | string | `"catalog-mongo"` | hostnames and ports of dependent services |
| catalog-product-catalog-administration.<<.services.offering | string | `"catalog-product-offering:8080"` | dependent service |
| catalog-product-catalog-administration.<<.services.offeringprice | string | `"catalog-product-offering-price:8080"` | dependent service |
| catalog-product-catalog-administration.<<.services.productcatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| catalog-product-catalog-administration.<<.services.specification | string | `"catalog-product-specification:8080"` | dependent service |
| catalog-product-catalog-administration.<<.services.userroleretrieve | string | `"auth-userrole:8080"` | dependent service |
| catalog-product-catalog-administration.fluentd.tag | string | `"catalog-product-catalog-administration"` |  |
| catalog-product-catalog-administration.monitoring.application | string | `"catalog-product-catalog-administration"` |  |
| catalog-product-catalog.<<.contextPath | string | `""` | context path of the application |
| catalog-product-catalog.<<.dailyshutdown | string | `"enabled"` | enable or disable application daily shutdown |
| catalog-product-catalog.<<.database.enabled | bool | `true` | enable database creation |
| catalog-product-catalog.<<.database.rootPassword | string | `"${CATALOG_MONGO_PASSWORD}"` | database root password |
| catalog-product-catalog.<<.database.rootUser | string | `"mongo_user"` | database root user |
| catalog-product-catalog.<<.fluentd.enabled | bool | `false` | enable fluentd sidecar container |
| catalog-product-catalog.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| catalog-product-catalog.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| catalog-product-catalog.<<.imagePullSecrets | list | `[]` | specify pulling image secrets if your image repository requires it |
| catalog-product-catalog.<<.ingress.annotations | object | `{}` | ingress annotations |
| catalog-product-catalog.<<.ingress.enabled | bool | `false` | enable ingress controller |
| catalog-product-catalog.<<.ingress.hosts[0].host | string | `""` |  |
| catalog-product-catalog.<<.ingress.hosts[0].paths[0] | string | `"/"` |  |
| catalog-product-catalog.<<.keyStoreP12 | string | `""` | keystore in P12 format, base64 encoded |
| catalog-product-catalog.<<.keycloak.enabled | bool | `false` | enable keycloak authentication |
| catalog-product-catalog.<<.keycloak.issuerURI | string | `"https://keycloak/realms/SpringBootKeycloak"` | keycloak issuer URI (to override) |
| catalog-product-catalog.<<.monitoring.application | string | `""` | label to specify application monitoring |
| catalog-product-catalog.<<.monitoring.domain | string | `""` |  |
| catalog-product-catalog.<<.monitoring.environment | string | `""` | label for environment being deployed |
| catalog-product-catalog.<<.monitoring.productName | string | `"discobole"` | label to specify product name (chart name by default) |
| catalog-product-catalog.<<.monitoring.role | string | `""` | label to specify role |
| catalog-product-catalog.<<.monitoring.topology | string | `""` | label to specify topology |
| catalog-product-catalog.<<.otel.attributes.cluster | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-catalog.<<.otel.attributes.hostname | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-catalog.<<.otel.attributes.namespace | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-catalog.<<.otel.attributes.platform | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-catalog.<<.otel.attributes.region | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-catalog.<<.otel.enabled | bool | `false` |  |
| catalog-product-catalog.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| catalog-product-catalog.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| catalog-product-catalog.<<.otel.sidecar.otlp | object | `{"host":null,"port":4317}` | main receiver address |
| catalog-product-catalog.<<.podAnnotations | object | `{}` |  |
| catalog-product-catalog.<<.replicaCount | int | `1` | application replica count |
| catalog-product-catalog.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| catalog-product-catalog.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| catalog-product-catalog.<<.service | object | `{"annotations":{},"port":8080,"type":"ClusterIP"}` | enable monitoring and supervision of pods prometheus.io/port: '9000' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' |
| catalog-product-catalog.<<.service.annotations | object | `{}` | enable monitoring and supervision of service     |
| catalog-product-catalog.<<.service.port | int | `8080` | service port  |
| catalog-product-catalog.<<.service.type | string | `"ClusterIP"` | service type |
| catalog-product-catalog.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| catalog-product-catalog.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| catalog-product-catalog.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| catalog-product-catalog.<<.services.catalogui | string | `"catalog-ui:80"` | dependent service |
| catalog-product-catalog.<<.services.category | string | `"catalog-product-category:8080"` | dependent service |
| catalog-product-catalog.<<.services.dbname | string | `"catalog"` | mongo database name |
| catalog-product-catalog.<<.services.gateway | string | `"disco-gateway:8080"` | dependent service |
| catalog-product-catalog.<<.services.kafka | string | `"kafka:9092"` | dependent service |
| catalog-product-catalog.<<.services.keycloak | string | `"keycloak:80"` | dependent service |
| catalog-product-catalog.<<.services.keycloakrealm | string | `"SpringBootKeycloak"` | keycloak realm |
| catalog-product-catalog.<<.services.keycloakroute | string | `"keycloak"` | dependent service |
| catalog-product-catalog.<<.services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` | dependent service |
| catalog-product-catalog.<<.services.mockservice | string | `"mock-service:80"` | dependent service |
| catalog-product-catalog.<<.services.mongodb | string | `"catalog-mongo"` | hostnames and ports of dependent services |
| catalog-product-catalog.<<.services.offering | string | `"catalog-product-offering:8080"` | dependent service |
| catalog-product-catalog.<<.services.offeringprice | string | `"catalog-product-offering-price:8080"` | dependent service |
| catalog-product-catalog.<<.services.productcatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| catalog-product-catalog.<<.services.specification | string | `"catalog-product-specification:8080"` | dependent service |
| catalog-product-catalog.<<.services.userroleretrieve | string | `"auth-userrole:8080"` | dependent service |
| catalog-product-catalog.fluentd.tag | string | `"catalog-product-catalog"` |  |
| catalog-product-catalog.mongo.architecture | string | `"standalone"` | mongoDB configuration |
| catalog-product-catalog.mongo.auth.enabled | bool | `false` | enable or disable mongoDB authentication |
| catalog-product-catalog.mongo.auth.rootPassword | string | `"${CATALOG_MONGO_PASSWORD}"` | mongoDB root password |
| catalog-product-catalog.mongo.auth.rootUser | string | `"mongo_user"` | mongoDB root user |
| catalog-product-catalog.mongo.directoryPerDB | bool | `true` | create performance directory per database |
| catalog-product-catalog.mongo.enabled | bool | `true` | enable or disable mongoDB deployment |
| catalog-product-catalog.mongo.extraEnvVarsSecret | string | `"product-catalog-mongo-secret"` | use extra env vars from secret |
| catalog-product-catalog.mongo.fullnameOverride | string | `"catalog-mongo"` | mongoDB fullname override |
| catalog-product-catalog.mongo.global.imageRegistry | string | `"registry.hub.docker.com"` | image registry to pull mongoDB images from |
| catalog-product-catalog.mongo.global.storageClass | string | `"block-default-storage-class"` | storage class to use for mongoDB persistent volume claims |
| catalog-product-catalog.mongo.hidden | object | `{"persistence":{"size":"4Gi"}}` | hidden mongoDB persistence configuration       |
| catalog-product-catalog.mongo.image.repository | string | `"bitnamilegacy/mongodb"` | mongoDB image repository |
| catalog-product-catalog.mongo.initdbScripts | object | `{"init.js":"// app user\ndb.getSiblingDB(\"catalog\")\nuse catalog;\nvar username='mongo_user';\nvar password=process.env[\"MONGO_DB_PWD\"];\nvar user=db.getUser(username);\nif (user == null) {\n  print('create user: ' + username);\n  db.createUser({user: 'mongo_user',pwd: password,roles: [ { role: 'readWrite', db: 'catalog' } ]});\n} else {\n  print('update user: ' + username);\n  db.updateUser(username, {pwd: password});\n}\nprint('---- done for ' + username);\nquit(0);\n"}` | database initialization scripts |
| catalog-product-catalog.mongo.persistence | object | `{"enabled":true,"size":"4Gi"}` | mongoDB persistence configuration |
| catalog-product-catalog.mongo.service | object | `{"nameOverride":"catalog-mongo","ports":{"mongodb":27017}}` | mongoDB  service configuration         |
| catalog-product-catalog.mongo.useStatefulSet | bool | `true` | use StatefulSet for mongoDB |
| catalog-product-catalog.monitoring.application | string | `"catalog-product-catalog"` |  |
| catalog-product-category.<<.contextPath | string | `""` | context path of the application |
| catalog-product-category.<<.dailyshutdown | string | `"enabled"` | enable or disable application daily shutdown |
| catalog-product-category.<<.database.enabled | bool | `true` | enable database creation |
| catalog-product-category.<<.database.rootPassword | string | `"${CATALOG_MONGO_PASSWORD}"` | database root password |
| catalog-product-category.<<.database.rootUser | string | `"mongo_user"` | database root user |
| catalog-product-category.<<.fluentd.enabled | bool | `false` | enable fluentd sidecar container |
| catalog-product-category.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| catalog-product-category.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| catalog-product-category.<<.imagePullSecrets | list | `[]` | specify pulling image secrets if your image repository requires it |
| catalog-product-category.<<.ingress.annotations | object | `{}` | ingress annotations |
| catalog-product-category.<<.ingress.enabled | bool | `false` | enable ingress controller |
| catalog-product-category.<<.ingress.hosts[0].host | string | `""` |  |
| catalog-product-category.<<.ingress.hosts[0].paths[0] | string | `"/"` |  |
| catalog-product-category.<<.keyStoreP12 | string | `""` | keystore in P12 format, base64 encoded |
| catalog-product-category.<<.keycloak.enabled | bool | `false` | enable keycloak authentication |
| catalog-product-category.<<.keycloak.issuerURI | string | `"https://keycloak/realms/SpringBootKeycloak"` | keycloak issuer URI (to override) |
| catalog-product-category.<<.monitoring.application | string | `""` | label to specify application monitoring |
| catalog-product-category.<<.monitoring.domain | string | `""` |  |
| catalog-product-category.<<.monitoring.environment | string | `""` | label for environment being deployed |
| catalog-product-category.<<.monitoring.productName | string | `"discobole"` | label to specify product name (chart name by default) |
| catalog-product-category.<<.monitoring.role | string | `""` | label to specify role |
| catalog-product-category.<<.monitoring.topology | string | `""` | label to specify topology |
| catalog-product-category.<<.otel.attributes.cluster | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-category.<<.otel.attributes.hostname | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-category.<<.otel.attributes.namespace | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-category.<<.otel.attributes.platform | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-category.<<.otel.attributes.region | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-category.<<.otel.enabled | bool | `false` |  |
| catalog-product-category.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| catalog-product-category.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| catalog-product-category.<<.otel.sidecar.otlp | object | `{"host":null,"port":4317}` | main receiver address |
| catalog-product-category.<<.podAnnotations | object | `{}` |  |
| catalog-product-category.<<.replicaCount | int | `1` | application replica count |
| catalog-product-category.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| catalog-product-category.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| catalog-product-category.<<.service | object | `{"annotations":{},"port":8080,"type":"ClusterIP"}` | enable monitoring and supervision of pods prometheus.io/port: '9000' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' |
| catalog-product-category.<<.service.annotations | object | `{}` | enable monitoring and supervision of service     |
| catalog-product-category.<<.service.port | int | `8080` | service port  |
| catalog-product-category.<<.service.type | string | `"ClusterIP"` | service type |
| catalog-product-category.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| catalog-product-category.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| catalog-product-category.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| catalog-product-category.<<.services.catalogui | string | `"catalog-ui:80"` | dependent service |
| catalog-product-category.<<.services.category | string | `"catalog-product-category:8080"` | dependent service |
| catalog-product-category.<<.services.dbname | string | `"catalog"` | mongo database name |
| catalog-product-category.<<.services.gateway | string | `"disco-gateway:8080"` | dependent service |
| catalog-product-category.<<.services.kafka | string | `"kafka:9092"` | dependent service |
| catalog-product-category.<<.services.keycloak | string | `"keycloak:80"` | dependent service |
| catalog-product-category.<<.services.keycloakrealm | string | `"SpringBootKeycloak"` | keycloak realm |
| catalog-product-category.<<.services.keycloakroute | string | `"keycloak"` | dependent service |
| catalog-product-category.<<.services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` | dependent service |
| catalog-product-category.<<.services.mockservice | string | `"mock-service:80"` | dependent service |
| catalog-product-category.<<.services.mongodb | string | `"catalog-mongo"` | hostnames and ports of dependent services |
| catalog-product-category.<<.services.offering | string | `"catalog-product-offering:8080"` | dependent service |
| catalog-product-category.<<.services.offeringprice | string | `"catalog-product-offering-price:8080"` | dependent service |
| catalog-product-category.<<.services.productcatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| catalog-product-category.<<.services.specification | string | `"catalog-product-specification:8080"` | dependent service |
| catalog-product-category.<<.services.userroleretrieve | string | `"auth-userrole:8080"` | dependent service |
| catalog-product-category.fluentd.tag | string | `"catalog-product-category"` |  |
| catalog-product-category.monitoring.application | string | `"catalog-product-category"` |  |
| catalog-product-category.services.catprodcaturl | string | `"https://catalog-product-catalog"` | catalog API URL |
| catalog-product-lifecycle-management.<<.contextPath | string | `""` | context path of the application |
| catalog-product-lifecycle-management.<<.dailyshutdown | string | `"enabled"` | enable or disable application daily shutdown |
| catalog-product-lifecycle-management.<<.database.enabled | bool | `true` | enable database creation |
| catalog-product-lifecycle-management.<<.database.rootPassword | string | `"${CATALOG_MONGO_PASSWORD}"` | database root password |
| catalog-product-lifecycle-management.<<.database.rootUser | string | `"mongo_user"` | database root user |
| catalog-product-lifecycle-management.<<.fluentd.enabled | bool | `false` | enable fluentd sidecar container |
| catalog-product-lifecycle-management.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| catalog-product-lifecycle-management.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| catalog-product-lifecycle-management.<<.imagePullSecrets | list | `[]` | specify pulling image secrets if your image repository requires it |
| catalog-product-lifecycle-management.<<.ingress.annotations | object | `{}` | ingress annotations |
| catalog-product-lifecycle-management.<<.ingress.enabled | bool | `false` | enable ingress controller |
| catalog-product-lifecycle-management.<<.ingress.hosts[0].host | string | `""` |  |
| catalog-product-lifecycle-management.<<.ingress.hosts[0].paths[0] | string | `"/"` |  |
| catalog-product-lifecycle-management.<<.keyStoreP12 | string | `""` | keystore in P12 format, base64 encoded |
| catalog-product-lifecycle-management.<<.keycloak.enabled | bool | `false` | enable keycloak authentication |
| catalog-product-lifecycle-management.<<.keycloak.issuerURI | string | `"https://keycloak/realms/SpringBootKeycloak"` | keycloak issuer URI (to override) |
| catalog-product-lifecycle-management.<<.monitoring.application | string | `""` | label to specify application monitoring |
| catalog-product-lifecycle-management.<<.monitoring.domain | string | `""` |  |
| catalog-product-lifecycle-management.<<.monitoring.environment | string | `""` | label for environment being deployed |
| catalog-product-lifecycle-management.<<.monitoring.productName | string | `"discobole"` | label to specify product name (chart name by default) |
| catalog-product-lifecycle-management.<<.monitoring.role | string | `""` | label to specify role |
| catalog-product-lifecycle-management.<<.monitoring.topology | string | `""` | label to specify topology |
| catalog-product-lifecycle-management.<<.otel.attributes.cluster | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-lifecycle-management.<<.otel.attributes.hostname | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-lifecycle-management.<<.otel.attributes.namespace | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-lifecycle-management.<<.otel.attributes.platform | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-lifecycle-management.<<.otel.attributes.region | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-lifecycle-management.<<.otel.enabled | bool | `false` |  |
| catalog-product-lifecycle-management.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| catalog-product-lifecycle-management.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| catalog-product-lifecycle-management.<<.otel.sidecar.otlp | object | `{"host":null,"port":4317}` | main receiver address |
| catalog-product-lifecycle-management.<<.podAnnotations | object | `{}` |  |
| catalog-product-lifecycle-management.<<.replicaCount | int | `1` | application replica count |
| catalog-product-lifecycle-management.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| catalog-product-lifecycle-management.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| catalog-product-lifecycle-management.<<.service | object | `{"annotations":{},"port":8080,"type":"ClusterIP"}` | enable monitoring and supervision of pods prometheus.io/port: '9000' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' |
| catalog-product-lifecycle-management.<<.service.annotations | object | `{}` | enable monitoring and supervision of service     |
| catalog-product-lifecycle-management.<<.service.port | int | `8080` | service port  |
| catalog-product-lifecycle-management.<<.service.type | string | `"ClusterIP"` | service type |
| catalog-product-lifecycle-management.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| catalog-product-lifecycle-management.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| catalog-product-lifecycle-management.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| catalog-product-lifecycle-management.<<.services.catalogui | string | `"catalog-ui:80"` | dependent service |
| catalog-product-lifecycle-management.<<.services.category | string | `"catalog-product-category:8080"` | dependent service |
| catalog-product-lifecycle-management.<<.services.dbname | string | `"catalog"` | mongo database name |
| catalog-product-lifecycle-management.<<.services.gateway | string | `"disco-gateway:8080"` | dependent service |
| catalog-product-lifecycle-management.<<.services.kafka | string | `"kafka:9092"` | dependent service |
| catalog-product-lifecycle-management.<<.services.keycloak | string | `"keycloak:80"` | dependent service |
| catalog-product-lifecycle-management.<<.services.keycloakrealm | string | `"SpringBootKeycloak"` | keycloak realm |
| catalog-product-lifecycle-management.<<.services.keycloakroute | string | `"keycloak"` | dependent service |
| catalog-product-lifecycle-management.<<.services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` | dependent service |
| catalog-product-lifecycle-management.<<.services.mockservice | string | `"mock-service:80"` | dependent service |
| catalog-product-lifecycle-management.<<.services.mongodb | string | `"catalog-mongo"` | hostnames and ports of dependent services |
| catalog-product-lifecycle-management.<<.services.offering | string | `"catalog-product-offering:8080"` | dependent service |
| catalog-product-lifecycle-management.<<.services.offeringprice | string | `"catalog-product-offering-price:8080"` | dependent service |
| catalog-product-lifecycle-management.<<.services.productcatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| catalog-product-lifecycle-management.<<.services.specification | string | `"catalog-product-specification:8080"` | dependent service |
| catalog-product-lifecycle-management.<<.services.userroleretrieve | string | `"auth-userrole:8080"` | dependent service |
| catalog-product-lifecycle-management.fluentd.tag | string | `"catalog-product-lifecycle-management"` |  |
| catalog-product-lifecycle-management.monitoring.application | string | `"catalog-product-lifecycle-management"` |  |
| catalog-product-lifecycle-management.services.administration | string | `"catalog-product-catalog-administration:8080"` | dependent service |
| catalog-product-lifecycle-management.services.cpib | string | `"product-inventory8080"` | dependent service |
| catalog-product-offering-price.<<.contextPath | string | `""` | context path of the application |
| catalog-product-offering-price.<<.dailyshutdown | string | `"enabled"` | enable or disable application daily shutdown |
| catalog-product-offering-price.<<.database.enabled | bool | `true` | enable database creation |
| catalog-product-offering-price.<<.database.rootPassword | string | `"${CATALOG_MONGO_PASSWORD}"` | database root password |
| catalog-product-offering-price.<<.database.rootUser | string | `"mongo_user"` | database root user |
| catalog-product-offering-price.<<.fluentd.enabled | bool | `false` | enable fluentd sidecar container |
| catalog-product-offering-price.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| catalog-product-offering-price.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| catalog-product-offering-price.<<.imagePullSecrets | list | `[]` | specify pulling image secrets if your image repository requires it |
| catalog-product-offering-price.<<.ingress.annotations | object | `{}` | ingress annotations |
| catalog-product-offering-price.<<.ingress.enabled | bool | `false` | enable ingress controller |
| catalog-product-offering-price.<<.ingress.hosts[0].host | string | `""` |  |
| catalog-product-offering-price.<<.ingress.hosts[0].paths[0] | string | `"/"` |  |
| catalog-product-offering-price.<<.keyStoreP12 | string | `""` | keystore in P12 format, base64 encoded |
| catalog-product-offering-price.<<.keycloak.enabled | bool | `false` | enable keycloak authentication |
| catalog-product-offering-price.<<.keycloak.issuerURI | string | `"https://keycloak/realms/SpringBootKeycloak"` | keycloak issuer URI (to override) |
| catalog-product-offering-price.<<.monitoring.application | string | `""` | label to specify application monitoring |
| catalog-product-offering-price.<<.monitoring.domain | string | `""` |  |
| catalog-product-offering-price.<<.monitoring.environment | string | `""` | label for environment being deployed |
| catalog-product-offering-price.<<.monitoring.productName | string | `"discobole"` | label to specify product name (chart name by default) |
| catalog-product-offering-price.<<.monitoring.role | string | `""` | label to specify role |
| catalog-product-offering-price.<<.monitoring.topology | string | `""` | label to specify topology |
| catalog-product-offering-price.<<.otel.attributes.cluster | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-offering-price.<<.otel.attributes.hostname | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-offering-price.<<.otel.attributes.namespace | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-offering-price.<<.otel.attributes.platform | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-offering-price.<<.otel.attributes.region | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-offering-price.<<.otel.enabled | bool | `false` |  |
| catalog-product-offering-price.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| catalog-product-offering-price.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| catalog-product-offering-price.<<.otel.sidecar.otlp | object | `{"host":null,"port":4317}` | main receiver address |
| catalog-product-offering-price.<<.podAnnotations | object | `{}` |  |
| catalog-product-offering-price.<<.replicaCount | int | `1` | application replica count |
| catalog-product-offering-price.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| catalog-product-offering-price.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| catalog-product-offering-price.<<.service | object | `{"annotations":{},"port":8080,"type":"ClusterIP"}` | enable monitoring and supervision of pods prometheus.io/port: '9000' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' |
| catalog-product-offering-price.<<.service.annotations | object | `{}` | enable monitoring and supervision of service     |
| catalog-product-offering-price.<<.service.port | int | `8080` | service port  |
| catalog-product-offering-price.<<.service.type | string | `"ClusterIP"` | service type |
| catalog-product-offering-price.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| catalog-product-offering-price.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| catalog-product-offering-price.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| catalog-product-offering-price.<<.services.catalogui | string | `"catalog-ui:80"` | dependent service |
| catalog-product-offering-price.<<.services.category | string | `"catalog-product-category:8080"` | dependent service |
| catalog-product-offering-price.<<.services.dbname | string | `"catalog"` | mongo database name |
| catalog-product-offering-price.<<.services.gateway | string | `"disco-gateway:8080"` | dependent service |
| catalog-product-offering-price.<<.services.kafka | string | `"kafka:9092"` | dependent service |
| catalog-product-offering-price.<<.services.keycloak | string | `"keycloak:80"` | dependent service |
| catalog-product-offering-price.<<.services.keycloakrealm | string | `"SpringBootKeycloak"` | keycloak realm |
| catalog-product-offering-price.<<.services.keycloakroute | string | `"keycloak"` | dependent service |
| catalog-product-offering-price.<<.services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` | dependent service |
| catalog-product-offering-price.<<.services.mockservice | string | `"mock-service:80"` | dependent service |
| catalog-product-offering-price.<<.services.mongodb | string | `"catalog-mongo"` | hostnames and ports of dependent services |
| catalog-product-offering-price.<<.services.offering | string | `"catalog-product-offering:8080"` | dependent service |
| catalog-product-offering-price.<<.services.offeringprice | string | `"catalog-product-offering-price:8080"` | dependent service |
| catalog-product-offering-price.<<.services.productcatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| catalog-product-offering-price.<<.services.specification | string | `"catalog-product-specification:8080"` | dependent service |
| catalog-product-offering-price.<<.services.userroleretrieve | string | `"auth-userrole:8080"` | dependent service |
| catalog-product-offering-price.fluentd | string | `nil` |  |
| catalog-product-offering-price.monitoring.application | string | `"catalog-product-offering-price"` |  |
| catalog-product-offering-price.services.adminstration | string | `"catalog-product-catalog-administration:8080"` | dependent service |
| catalog-product-offering-price.services.catprodcaturl | string | `"https://catalog-product-catalog"` | catalog API URL |
| catalog-product-offering-price.tag | string | `"catalog-product-offering-price"` |  |
| catalog-product-offering.<<.contextPath | string | `""` | context path of the application |
| catalog-product-offering.<<.dailyshutdown | string | `"enabled"` | enable or disable application daily shutdown |
| catalog-product-offering.<<.database.enabled | bool | `true` | enable database creation |
| catalog-product-offering.<<.database.rootPassword | string | `"${CATALOG_MONGO_PASSWORD}"` | database root password |
| catalog-product-offering.<<.database.rootUser | string | `"mongo_user"` | database root user |
| catalog-product-offering.<<.fluentd.enabled | bool | `false` | enable fluentd sidecar container |
| catalog-product-offering.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| catalog-product-offering.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| catalog-product-offering.<<.imagePullSecrets | list | `[]` | specify pulling image secrets if your image repository requires it |
| catalog-product-offering.<<.ingress.annotations | object | `{}` | ingress annotations |
| catalog-product-offering.<<.ingress.enabled | bool | `false` | enable ingress controller |
| catalog-product-offering.<<.ingress.hosts[0].host | string | `""` |  |
| catalog-product-offering.<<.ingress.hosts[0].paths[0] | string | `"/"` |  |
| catalog-product-offering.<<.keyStoreP12 | string | `""` | keystore in P12 format, base64 encoded |
| catalog-product-offering.<<.keycloak.enabled | bool | `false` | enable keycloak authentication |
| catalog-product-offering.<<.keycloak.issuerURI | string | `"https://keycloak/realms/SpringBootKeycloak"` | keycloak issuer URI (to override) |
| catalog-product-offering.<<.monitoring.application | string | `""` | label to specify application monitoring |
| catalog-product-offering.<<.monitoring.domain | string | `""` |  |
| catalog-product-offering.<<.monitoring.environment | string | `""` | label for environment being deployed |
| catalog-product-offering.<<.monitoring.productName | string | `"discobole"` | label to specify product name (chart name by default) |
| catalog-product-offering.<<.monitoring.role | string | `""` | label to specify role |
| catalog-product-offering.<<.monitoring.topology | string | `""` | label to specify topology |
| catalog-product-offering.<<.otel.attributes.cluster | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-offering.<<.otel.attributes.hostname | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-offering.<<.otel.attributes.namespace | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-offering.<<.otel.attributes.platform | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-offering.<<.otel.attributes.region | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-offering.<<.otel.enabled | bool | `false` |  |
| catalog-product-offering.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| catalog-product-offering.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| catalog-product-offering.<<.otel.sidecar.otlp | object | `{"host":null,"port":4317}` | main receiver address |
| catalog-product-offering.<<.podAnnotations | object | `{}` |  |
| catalog-product-offering.<<.replicaCount | int | `1` | application replica count |
| catalog-product-offering.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| catalog-product-offering.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| catalog-product-offering.<<.service | object | `{"annotations":{},"port":8080,"type":"ClusterIP"}` | enable monitoring and supervision of pods prometheus.io/port: '9000' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' |
| catalog-product-offering.<<.service.annotations | object | `{}` | enable monitoring and supervision of service     |
| catalog-product-offering.<<.service.port | int | `8080` | service port  |
| catalog-product-offering.<<.service.type | string | `"ClusterIP"` | service type |
| catalog-product-offering.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| catalog-product-offering.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| catalog-product-offering.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| catalog-product-offering.<<.services.catalogui | string | `"catalog-ui:80"` | dependent service |
| catalog-product-offering.<<.services.category | string | `"catalog-product-category:8080"` | dependent service |
| catalog-product-offering.<<.services.dbname | string | `"catalog"` | mongo database name |
| catalog-product-offering.<<.services.gateway | string | `"disco-gateway:8080"` | dependent service |
| catalog-product-offering.<<.services.kafka | string | `"kafka:9092"` | dependent service |
| catalog-product-offering.<<.services.keycloak | string | `"keycloak:80"` | dependent service |
| catalog-product-offering.<<.services.keycloakrealm | string | `"SpringBootKeycloak"` | keycloak realm |
| catalog-product-offering.<<.services.keycloakroute | string | `"keycloak"` | dependent service |
| catalog-product-offering.<<.services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` | dependent service |
| catalog-product-offering.<<.services.mockservice | string | `"mock-service:80"` | dependent service |
| catalog-product-offering.<<.services.mongodb | string | `"catalog-mongo"` | hostnames and ports of dependent services |
| catalog-product-offering.<<.services.offering | string | `"catalog-product-offering:8080"` | dependent service |
| catalog-product-offering.<<.services.offeringprice | string | `"catalog-product-offering-price:8080"` | dependent service |
| catalog-product-offering.<<.services.productcatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| catalog-product-offering.<<.services.specification | string | `"catalog-product-specification:8080"` | dependent service |
| catalog-product-offering.<<.services.userroleretrieve | string | `"auth-userrole:8080"` | dependent service |
| catalog-product-offering.fluentd.tag | string | `"catalog-product-offering"` |  |
| catalog-product-offering.monitoring.application | string | `"catalog-product-offering"` |  |
| catalog-product-offering.services.catalogadminstration | string | `"catalog-product-catalog-administration:8080"` | dependent service |
| catalog-product-offering.services.catprodcaturl | string | `"https://catalog-product-catalog"` | catalog API URL |
| catalog-product-offering.services.cpib | string | `"product-inventory8080"` | dependent service |
| catalog-product-specification.<<.contextPath | string | `""` | context path of the application |
| catalog-product-specification.<<.dailyshutdown | string | `"enabled"` | enable or disable application daily shutdown |
| catalog-product-specification.<<.database.enabled | bool | `true` | enable database creation |
| catalog-product-specification.<<.database.rootPassword | string | `"${CATALOG_MONGO_PASSWORD}"` | database root password |
| catalog-product-specification.<<.database.rootUser | string | `"mongo_user"` | database root user |
| catalog-product-specification.<<.fluentd.enabled | bool | `false` | enable fluentd sidecar container |
| catalog-product-specification.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| catalog-product-specification.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| catalog-product-specification.<<.imagePullSecrets | list | `[]` | specify pulling image secrets if your image repository requires it |
| catalog-product-specification.<<.ingress.annotations | object | `{}` | ingress annotations |
| catalog-product-specification.<<.ingress.enabled | bool | `false` | enable ingress controller |
| catalog-product-specification.<<.ingress.hosts[0].host | string | `""` |  |
| catalog-product-specification.<<.ingress.hosts[0].paths[0] | string | `"/"` |  |
| catalog-product-specification.<<.keyStoreP12 | string | `""` | keystore in P12 format, base64 encoded |
| catalog-product-specification.<<.keycloak.enabled | bool | `false` | enable keycloak authentication |
| catalog-product-specification.<<.keycloak.issuerURI | string | `"https://keycloak/realms/SpringBootKeycloak"` | keycloak issuer URI (to override) |
| catalog-product-specification.<<.monitoring.application | string | `""` | label to specify application monitoring |
| catalog-product-specification.<<.monitoring.domain | string | `""` |  |
| catalog-product-specification.<<.monitoring.environment | string | `""` | label for environment being deployed |
| catalog-product-specification.<<.monitoring.productName | string | `"discobole"` | label to specify product name (chart name by default) |
| catalog-product-specification.<<.monitoring.role | string | `""` | label to specify role |
| catalog-product-specification.<<.monitoring.topology | string | `""` | label to specify topology |
| catalog-product-specification.<<.otel.attributes.cluster | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-specification.<<.otel.attributes.hostname | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-specification.<<.otel.attributes.namespace | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-specification.<<.otel.attributes.platform | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-specification.<<.otel.attributes.region | string | `""` | resource attribute to be set on telemetry data |
| catalog-product-specification.<<.otel.enabled | bool | `false` |  |
| catalog-product-specification.<<.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| catalog-product-specification.<<.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| catalog-product-specification.<<.otel.sidecar.otlp | object | `{"host":null,"port":4317}` | main receiver address |
| catalog-product-specification.<<.podAnnotations | object | `{}` |  |
| catalog-product-specification.<<.replicaCount | int | `1` | application replica count |
| catalog-product-specification.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| catalog-product-specification.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| catalog-product-specification.<<.service | object | `{"annotations":{},"port":8080,"type":"ClusterIP"}` | enable monitoring and supervision of pods prometheus.io/port: '9000' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' |
| catalog-product-specification.<<.service.annotations | object | `{}` | enable monitoring and supervision of service     |
| catalog-product-specification.<<.service.port | int | `8080` | service port  |
| catalog-product-specification.<<.service.type | string | `"ClusterIP"` | service type |
| catalog-product-specification.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| catalog-product-specification.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| catalog-product-specification.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| catalog-product-specification.<<.services.catalogui | string | `"catalog-ui:80"` | dependent service |
| catalog-product-specification.<<.services.category | string | `"catalog-product-category:8080"` | dependent service |
| catalog-product-specification.<<.services.dbname | string | `"catalog"` | mongo database name |
| catalog-product-specification.<<.services.gateway | string | `"disco-gateway:8080"` | dependent service |
| catalog-product-specification.<<.services.kafka | string | `"kafka:9092"` | dependent service |
| catalog-product-specification.<<.services.keycloak | string | `"keycloak:80"` | dependent service |
| catalog-product-specification.<<.services.keycloakrealm | string | `"SpringBootKeycloak"` | keycloak realm |
| catalog-product-specification.<<.services.keycloakroute | string | `"keycloak"` | dependent service |
| catalog-product-specification.<<.services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` | dependent service |
| catalog-product-specification.<<.services.mockservice | string | `"mock-service:80"` | dependent service |
| catalog-product-specification.<<.services.mongodb | string | `"catalog-mongo"` | hostnames and ports of dependent services |
| catalog-product-specification.<<.services.offering | string | `"catalog-product-offering:8080"` | dependent service |
| catalog-product-specification.<<.services.offeringprice | string | `"catalog-product-offering-price:8080"` | dependent service |
| catalog-product-specification.<<.services.productcatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| catalog-product-specification.<<.services.specification | string | `"catalog-product-specification:8080"` | dependent service |
| catalog-product-specification.<<.services.userroleretrieve | string | `"auth-userrole:8080"` | dependent service |
| catalog-product-specification.fluentd.tag | string | `"catalog-product-specification"` |  |
| catalog-product-specification.monitoring.application | string | `"catalog-product-specification"` |  |
| catalog-product-specification.services.catadminstration | string | `"catalog-product-catalog-administration:8080"` | dependent service |
| catalog-product-specification.services.catprodcaturl | string | `"https://catalog-product-catalog"` | catalog API URL |
| catalog-product-specification.services.cpib | string | `"product-inventory8080"` | dependent service |
| common.contextPath | string | `""` | context path of the application |
| common.dailyshutdown | string | `"enabled"` | enable or disable application daily shutdown |
| common.database.enabled | bool | `true` | enable database creation |
| common.database.rootPassword | string | `"${CATALOG_MONGO_PASSWORD}"` | database root password |
| common.database.rootUser | string | `"mongo_user"` | database root user |
| common.fluentd.enabled | bool | `false` | enable fluentd sidecar container |
| common.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| common.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| common.imagePullSecrets | list | `[]` | specify pulling image secrets if your image repository requires it |
| common.ingress.annotations | object | `{}` | ingress annotations |
| common.ingress.enabled | bool | `false` | enable ingress controller |
| common.ingress.hosts[0].host | string | `""` |  |
| common.ingress.hosts[0].paths[0] | string | `"/"` |  |
| common.keyStoreP12 | string | `""` | keystore in P12 format, base64 encoded |
| common.keycloak.enabled | bool | `false` | enable keycloak authentication |
| common.keycloak.issuerURI | string | `"https://keycloak/realms/SpringBootKeycloak"` | keycloak issuer URI (to override) |
| common.monitoring.application | string | `""` | label to specify application monitoring |
| common.monitoring.domain | string | `""` |  |
| common.monitoring.environment | string | `""` | label for environment being deployed |
| common.monitoring.productName | string | `"discobole"` | label to specify product name (chart name by default) |
| common.monitoring.role | string | `""` | label to specify role |
| common.monitoring.topology | string | `""` | label to specify topology |
| common.otel.attributes.cluster | string | `""` | resource attribute to be set on telemetry data |
| common.otel.attributes.hostname | string | `""` | resource attribute to be set on telemetry data |
| common.otel.attributes.namespace | string | `""` | resource attribute to be set on telemetry data |
| common.otel.attributes.platform | string | `""` | resource attribute to be set on telemetry data |
| common.otel.attributes.region | string | `""` | resource attribute to be set on telemetry data |
| common.otel.enabled | bool | `false` |  |
| common.otel.sidecar.enabled | bool | `false` | use collector agent sidecar |
| common.otel.sidecar.jaeger | object | `{"host":"jaeger","port":14250}` | main collector address |
| common.otel.sidecar.otlp | object | `{"host":null,"port":4317}` | main receiver address |
| common.podAnnotations | object | `{}` |  |
| common.replicaCount | int | `1` | application replica count |
| common.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| common.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| common.service | object | `{"annotations":{},"port":8080,"type":"ClusterIP"}` | enable monitoring and supervision of pods prometheus.io/port: '9000' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' |
| common.service.annotations | object | `{}` | enable monitoring and supervision of service     |
| common.service.port | int | `8080` | service port  |
| common.service.type | string | `"ClusterIP"` | service type |
| common.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| common.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| common.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| common.services.catalogui | string | `"catalog-ui:80"` | dependent service |
| common.services.category | string | `"catalog-product-category:8080"` | dependent service |
| common.services.dbname | string | `"catalog"` | mongo database name |
| common.services.gateway | string | `"disco-gateway:8080"` | dependent service |
| common.services.kafka | string | `"kafka:9092"` | dependent service |
| common.services.keycloak | string | `"keycloak:80"` | dependent service |
| common.services.keycloakrealm | string | `"SpringBootKeycloak"` | keycloak realm |
| common.services.keycloakroute | string | `"keycloak"` | dependent service |
| common.services.lifecycle | string | `"catalog-product-lifecycle-management:8080"` | dependent service |
| common.services.mockservice | string | `"mock-service:80"` | dependent service |
| common.services.mongodb | string | `"catalog-mongo"` | hostnames and ports of dependent services |
| common.services.offering | string | `"catalog-product-offering:8080"` | dependent service |
| common.services.offeringprice | string | `"catalog-product-offering-price:8080"` | dependent service |
| common.services.productcatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| common.services.specification | string | `"catalog-product-specification:8080"` | dependent service |
| common.services.userroleretrieve | string | `"auth-userrole:8080"` | dependent service |
| fullnameOverride | string | `""` |  |
| image | object | `{}` |  |
| imagePullSecrets | list | `[]` |  |
| ingress | object | `{}` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
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
$ helm install my-release -f values.yaml discobole/catalog-component
```

## Docker image access

These values help you to configure access to the Docker image for this microservice.

- if you need to pull the Docker image from a private or protected registry, you have to create and specify an `imagePullSecret`
- if you wish to let the chart create the image pull secret for you, configure the `serviceAccount.imagePullSecret` section

In case you delegate the creation of an image pull secret, use your own credentials on the private or protected registry, as follows.

```bash
$ helm install my-release discobole/catalog-component \
--set serviceAccount.imagePullSecret.create=true \
--set serviceAccount.imagePullSecret.registry=<your private or protected docker registry> \
--set serviceAccount.imagePullSecret.username=<you username> \
--set serviceAccount.imagePullSecret.password=<your access token>
```
