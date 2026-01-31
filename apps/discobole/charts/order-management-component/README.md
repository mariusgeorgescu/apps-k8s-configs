<!--
SPDX-FileCopyrightText: 2025 Orange SA
SPDX-License-Identifier: MIT

This software is distributed under the MIT License,
the text of which is available at https://opensource.org/license/mit
or see the "LICENSE.txt" file for more details.

Authors: See CONTRIBUTORS.txt
-->

# orchestration-delivery-component

A Helm chart for installing Order Management Component.

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
helm install my-release discobole/order-component
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
$ helm install my-release discobole/order-component
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
| common.affinity | object | `{}` | node affinity for pod assignment |
| common.api.contextPath | string | `"/api/v2/"` |  |
| common.autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| common.autoscaling.maxReplicas | string | `""` | Maximum number of pod replicas |
| common.autoscaling.minReplicas | string | `""` | Minimum number of pod replicas |
| common.autoscaling.targetCPUUtilizationPercentage | string | `""` | Target CPU utilization percentages for pod scaling |
| common.autoscaling.targetMemoryUtilizationPercentage | string | `""` | Target Memory utilization percentages for pod scaling |
| common.certManager.create | bool | `false` |  |
| common.contextPath | string | `""` |  |
| common.fluentd.enabled | bool | `false` | set to true to enable fluentd logging |
| common.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| common.fluentd.port | string | `""` | port of the fluentd instance this application should send logs to. Defaults to localhost |
| common.fluentd.sidecar.enabled | bool | `false` | set to true to enable the fluentd sidecar container |
| common.fluentd.sidecar.loki | object | `{"extra_labels":"\"env\":\"sandbox\", \"app\": \"disco\"","url":""}` | loki output configuration for the fluentd sidecar |
| common.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| common.imagePullSecrets | list | `[]` | image pull secrets if you use a private registry |
| common.ingress.annotations | object | `{}` | ingress class annotations |
| common.ingress.className | string | `""` | ingress class name |
| common.ingress.enabled | bool | `false` |  |
| common.ingress.hosts[0] | object | `{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}` | ingress hostnames |
| common.ingress.tls | list | `[]` |  |
| common.jdkJavaOptions | string | `""` | extra java options to pass to the jvm |
| common.keyStoreP12 | string | `""` | base64 encoded p12 keystore file content |
| common.keycloak.clientId | string | `"${ORDER_KEYCLOAK_CLIENT_ID}"` | Keycloak client ID |
| common.keycloak.clientSecret | string | `"${ORDER_KEYCLOAK_CLIENT_SECRET}"` | Keycloak client secret |
| common.keycloak.enabled | bool | `false` | enable or disable Keycloak integration |
| common.keycloak.url | string | `"https://keycloak"` | Keycloak service URL |
| common.mongo.arbiter.enabled | bool | `false` | enable mongoDB arbiter for replica sets |
| common.mongo.architecture | string | `"standalone"` | mongoDB deployment architecture |
| common.mongo.auth.enabled | bool | `false` | enable mongoDB authentication |
| common.mongo.auth.rootPassword | string | `""` | mongoDB root user password |
| common.mongo.auth.rootUser | string | `"mongo_user"` | mongoDB root user name |
| common.mongo.commonLabels | object | `{"domain":"dbms","productname":"mongodb"}` | labels to add to mongoDB pods and services |
| common.mongo.directoryPerDB | bool | `true` | create a separate directory for each database |
| common.mongo.enabled | bool | `true` | enable or disable mongoDB deployment |
| common.mongo.extraEnvVarsSecret | string | `""` | extra environment variables to set on mongoDB pods from a secret |
| common.mongo.fullnameOverride | string | `""` | scripts to run on mongoDB initialization |
| common.mongo.global.imageRegistry | string | `"registry.hub.docker.com"` | image registry to pull mongoDB images from |
| common.mongo.global.storageClass | string | `"block-default-storage-class"` | storage class to use for mongoDB persistent volume claims |
| common.mongo.image.repository | string | `"bitnamilegacy/mongodb"` | mongoDB image repository |
| common.mongo.initdbScripts | object | `{}` | database initialization scripts |
| common.mongo.metrics.enabled | bool | `true` |  |
| common.mongo.metrics.image.repository | string | `"bitnamilegacy/mongodb-exporter"` | mongoDB exporter image repository |
| common.mongo.podAnnotations | object | `{"prometheus.io/path":"/metrics","prometheus.io/port":"9216","prometheus.io/scrape":"true"}` | enable monitoring and supervision of mongoDB pods |
| common.mongo.resources.limits | object | `{"memory":"1500Mi"}` | resource requests and limits for mongoDB pods |
| common.mongo.service | object | `{"nameOverride":"","ports":{"mongodb":27017}}` | service configuration for mongoDB |
| common.mongo.useStatefulSet | bool | `true` | use statefulset for mongoDB deployment |
| common.monitoring.application | string | `""` | label to specify application name |
| common.monitoring.domain | string | `""` | label for exporter autodetection |
| common.monitoring.environment | string | `""` | label for environment being deployed |
| common.monitoring.productName | string | `"discobole"` | label to specify product name  |
| common.monitoring.role | string | `""` | label to specify role |
| common.monitoring.topology | string | `""` | label to specify topology |
| common.nodeSelector | object | `{}` | node selectorfor pod assignment |
| common.otel.enabled | bool | `false` | activate Open Telemetry instrumentation |
| common.otel.sidecar.collector.host | string | `""` | otlp main collector host (defaults to "otel-collector") |
| common.otel.sidecar.collector.port | int | `14250` | otlp main collector port (defaults to otlp 4317 port on main otel collector) |
| common.otel.sidecar.enabled | bool | `false` | set to true to enable collector agent sidecar |
| common.otel.sidecar.exporter | string | `""` | otlp protocol to use in sidecar exporter (only otlp is available in default config) |
| common.podAnnotations | object | `{}` |  |
| common.podSecurityContext | object | `{}` | enable monitoring and supervision of pods prometheus.io/port: '8080' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' # align with contextPath, if specified remove curly braces and specify if necessary |
| common.registryCredentials.create | bool | `false` | specifies whether a registry credentials secret should be created |
| common.registryCredentials.token.password | string | `""` |  |
| common.registryCredentials.token.userName | string | `""` |  |
| common.registryCredentials.url | string | `""` | example for GitLab internal registry |
| common.replicaCount | int | `1` | application replica count |
| common.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| common.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| common.securityContext | object | `{}` |  |
| common.service.annotations | object | `{}` | enable monitoring and supervision of service |
| common.service.port | int | `8080` | service port |
| common.service.type | string | `"ClusterIP"` | service type |
| common.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| common.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| common.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| common.tolerations | list | `[]` | node tolerations for pod assignment |
| fullnameOverride | string | `""` |  |
| image | object | `{}` |  |
| imagePullSecrets | list | `[]` |  |
| ingress | object | `{}` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| order-capture.<<.affinity | object | `{}` | node affinity for pod assignment |
| order-capture.<<.api.contextPath | string | `"/api/v2/"` |  |
| order-capture.<<.autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| order-capture.<<.autoscaling.maxReplicas | string | `""` | Maximum number of pod replicas |
| order-capture.<<.autoscaling.minReplicas | string | `""` | Minimum number of pod replicas |
| order-capture.<<.autoscaling.targetCPUUtilizationPercentage | string | `""` | Target CPU utilization percentages for pod scaling |
| order-capture.<<.autoscaling.targetMemoryUtilizationPercentage | string | `""` | Target Memory utilization percentages for pod scaling |
| order-capture.<<.certManager.create | bool | `false` |  |
| order-capture.<<.contextPath | string | `""` |  |
| order-capture.<<.fluentd.enabled | bool | `false` | set to true to enable fluentd logging |
| order-capture.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| order-capture.<<.fluentd.port | string | `""` | port of the fluentd instance this application should send logs to. Defaults to localhost |
| order-capture.<<.fluentd.sidecar.enabled | bool | `false` | set to true to enable the fluentd sidecar container |
| order-capture.<<.fluentd.sidecar.loki | object | `{"extra_labels":"\"env\":\"sandbox\", \"app\": \"disco\"","url":""}` | loki output configuration for the fluentd sidecar |
| order-capture.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| order-capture.<<.imagePullSecrets | list | `[]` | image pull secrets if you use a private registry |
| order-capture.<<.ingress.annotations | object | `{}` | ingress class annotations |
| order-capture.<<.ingress.className | string | `""` | ingress class name |
| order-capture.<<.ingress.enabled | bool | `false` |  |
| order-capture.<<.ingress.hosts[0] | object | `{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}` | ingress hostnames |
| order-capture.<<.ingress.tls | list | `[]` |  |
| order-capture.<<.jdkJavaOptions | string | `""` | extra java options to pass to the jvm |
| order-capture.<<.keyStoreP12 | string | `""` | base64 encoded p12 keystore file content |
| order-capture.<<.keycloak.clientId | string | `"${ORDER_KEYCLOAK_CLIENT_ID}"` | Keycloak client ID |
| order-capture.<<.keycloak.clientSecret | string | `"${ORDER_KEYCLOAK_CLIENT_SECRET}"` | Keycloak client secret |
| order-capture.<<.keycloak.enabled | bool | `false` | enable or disable Keycloak integration |
| order-capture.<<.keycloak.url | string | `"https://keycloak"` | Keycloak service URL |
| order-capture.<<.mongo.arbiter.enabled | bool | `false` | enable mongoDB arbiter for replica sets |
| order-capture.<<.mongo.architecture | string | `"standalone"` | mongoDB deployment architecture |
| order-capture.<<.mongo.auth.enabled | bool | `false` | enable mongoDB authentication |
| order-capture.<<.mongo.auth.rootPassword | string | `""` | mongoDB root user password |
| order-capture.<<.mongo.auth.rootUser | string | `"mongo_user"` | mongoDB root user name |
| order-capture.<<.mongo.commonLabels | object | `{"domain":"dbms","productname":"mongodb"}` | labels to add to mongoDB pods and services |
| order-capture.<<.mongo.directoryPerDB | bool | `true` | create a separate directory for each database |
| order-capture.<<.mongo.enabled | bool | `true` | enable or disable mongoDB deployment |
| order-capture.<<.mongo.extraEnvVarsSecret | string | `""` | extra environment variables to set on mongoDB pods from a secret |
| order-capture.<<.mongo.fullnameOverride | string | `""` | scripts to run on mongoDB initialization |
| order-capture.<<.mongo.global.imageRegistry | string | `"registry.hub.docker.com"` | image registry to pull mongoDB images from |
| order-capture.<<.mongo.global.storageClass | string | `"block-default-storage-class"` | storage class to use for mongoDB persistent volume claims |
| order-capture.<<.mongo.image.repository | string | `"bitnamilegacy/mongodb"` | mongoDB image repository |
| order-capture.<<.mongo.initdbScripts | object | `{}` | database initialization scripts |
| order-capture.<<.mongo.metrics.enabled | bool | `true` |  |
| order-capture.<<.mongo.metrics.image.repository | string | `"bitnamilegacy/mongodb-exporter"` | mongoDB exporter image repository |
| order-capture.<<.mongo.podAnnotations | object | `{"prometheus.io/path":"/metrics","prometheus.io/port":"9216","prometheus.io/scrape":"true"}` | enable monitoring and supervision of mongoDB pods |
| order-capture.<<.mongo.resources.limits | object | `{"memory":"1500Mi"}` | resource requests and limits for mongoDB pods |
| order-capture.<<.mongo.service | object | `{"nameOverride":"","ports":{"mongodb":27017}}` | service configuration for mongoDB |
| order-capture.<<.mongo.useStatefulSet | bool | `true` | use statefulset for mongoDB deployment |
| order-capture.<<.monitoring.application | string | `""` | label to specify application name |
| order-capture.<<.monitoring.domain | string | `""` | label for exporter autodetection |
| order-capture.<<.monitoring.environment | string | `""` | label for environment being deployed |
| order-capture.<<.monitoring.productName | string | `"discobole"` | label to specify product name  |
| order-capture.<<.monitoring.role | string | `""` | label to specify role |
| order-capture.<<.monitoring.topology | string | `""` | label to specify topology |
| order-capture.<<.nodeSelector | object | `{}` | node selectorfor pod assignment |
| order-capture.<<.otel.enabled | bool | `false` | activate Open Telemetry instrumentation |
| order-capture.<<.otel.sidecar.collector.host | string | `""` | otlp main collector host (defaults to "otel-collector") |
| order-capture.<<.otel.sidecar.collector.port | int | `14250` | otlp main collector port (defaults to otlp 4317 port on main otel collector) |
| order-capture.<<.otel.sidecar.enabled | bool | `false` | set to true to enable collector agent sidecar |
| order-capture.<<.otel.sidecar.exporter | string | `""` | otlp protocol to use in sidecar exporter (only otlp is available in default config) |
| order-capture.<<.podAnnotations | object | `{}` |  |
| order-capture.<<.podSecurityContext | object | `{}` | enable monitoring and supervision of pods prometheus.io/port: '8080' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' # align with contextPath, if specified remove curly braces and specify if necessary |
| order-capture.<<.registryCredentials.create | bool | `false` | specifies whether a registry credentials secret should be created |
| order-capture.<<.registryCredentials.token.password | string | `""` |  |
| order-capture.<<.registryCredentials.token.userName | string | `""` |  |
| order-capture.<<.registryCredentials.url | string | `""` | example for GitLab internal registry |
| order-capture.<<.replicaCount | int | `1` | application replica count |
| order-capture.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| order-capture.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| order-capture.<<.securityContext | object | `{}` |  |
| order-capture.<<.service.annotations | object | `{}` | enable monitoring and supervision of service |
| order-capture.<<.service.port | int | `8080` | service port |
| order-capture.<<.service.type | string | `"ClusterIP"` | service type |
| order-capture.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| order-capture.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| order-capture.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| order-capture.<<.tolerations | list | `[]` | node tolerations for pod assignment |
| order-capture.fluentd.tag | string | `"order-capture"` |  |
| order-capture.mongo.auth.enabled | bool | `false` | enable mongoDB authentication |
| order-capture.mongo.auth.rootPassword | string | `"${ORDER_CAPTURE_MONGO_PASSWORD}"` | mongoDB root user password |
| order-capture.mongo.auth.rootUser | string | `"mongo_user"` | mongoDB root user name |
| order-capture.mongo.enabled | bool | `true` | enable or disable mongoDB deployment |
| order-capture.mongo.extraEnvVarsSecret | string | `"order-capture-mongo-secret"` | extra environment variables to set on mongoDB pods from a secret |
| order-capture.mongo.fullnameOverride | string | `"order-capture-mongo"` | mongoDB fullname override |
| order-capture.mongo.initdbScripts."init.js" | string | `"// app user\ndb.getSiblingDB(\"order_capture\")\nuse order_capture;\ndb.createCollection(\"dummy_table\")\ndb.dummy_table.insertOne({\"desc\" : \"create dummy row to create database\"})\nvar username='mongo_user';\nvar password=process.env[\"MONGO_DB_PWD\"];\nvar user=db.getUser(username);\nif (user == null) {\n  print('create user: ' + username);\n  db.createUser({user: 'mongo_user',pwd: password,roles: [ { role: 'readWrite', db: 'order_capture' } ]});\n} else {\n  print('update user: ' + username);\n  db.updateUser(username, {pwd: password});\n}\nprint('---- done for ' + username);\nquit(0);\n"` |  |
| order-capture.mongo.service | object | `{"nameOverride":"order-capture-mongo"}` | service configuration for mongoDB |
| order-capture.monitoring.application | string | `"order-capture"` |  |
| order-capture.oc.service.authUserRole | string | `"auth-userrole:8080"` | dependent service |
| order-capture.oc.service.kafka | string | `"kafka"` | dependent service |
| order-capture.oc.service.mockServer | string | `"mock-server:8080"` | dependent service |
| order-capture.oc.service.orderInventory | string | `"order-inventory:8080"` | dependent service |
| order-capture.oc.service.poi | string | `"order-inventory:8080"` | dependent service |
| order-capture.oc.service.productCatalog | string | `"catalog-product-catalog:8080"` | dependent service |
| order-capture.oc.service.productConfigurator | string | `"product-configurator:8080"` | dependent service |
| order-capture.oc.service.productInventory | string | `"product-inventory:8080"` | dependent service |
| order-followup.<<.affinity | object | `{}` | node affinity for pod assignment |
| order-followup.<<.api.contextPath | string | `"/api/v2/"` |  |
| order-followup.<<.autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| order-followup.<<.autoscaling.maxReplicas | string | `""` | Maximum number of pod replicas |
| order-followup.<<.autoscaling.minReplicas | string | `""` | Minimum number of pod replicas |
| order-followup.<<.autoscaling.targetCPUUtilizationPercentage | string | `""` | Target CPU utilization percentages for pod scaling |
| order-followup.<<.autoscaling.targetMemoryUtilizationPercentage | string | `""` | Target Memory utilization percentages for pod scaling |
| order-followup.<<.certManager.create | bool | `false` |  |
| order-followup.<<.contextPath | string | `""` |  |
| order-followup.<<.fluentd.enabled | bool | `false` | set to true to enable fluentd logging |
| order-followup.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| order-followup.<<.fluentd.port | string | `""` | port of the fluentd instance this application should send logs to. Defaults to localhost |
| order-followup.<<.fluentd.sidecar.enabled | bool | `false` | set to true to enable the fluentd sidecar container |
| order-followup.<<.fluentd.sidecar.loki | object | `{"extra_labels":"\"env\":\"sandbox\", \"app\": \"disco\"","url":""}` | loki output configuration for the fluentd sidecar |
| order-followup.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| order-followup.<<.imagePullSecrets | list | `[]` | image pull secrets if you use a private registry |
| order-followup.<<.ingress.annotations | object | `{}` | ingress class annotations |
| order-followup.<<.ingress.className | string | `""` | ingress class name |
| order-followup.<<.ingress.enabled | bool | `false` |  |
| order-followup.<<.ingress.hosts[0] | object | `{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}` | ingress hostnames |
| order-followup.<<.ingress.tls | list | `[]` |  |
| order-followup.<<.jdkJavaOptions | string | `""` | extra java options to pass to the jvm |
| order-followup.<<.keyStoreP12 | string | `""` | base64 encoded p12 keystore file content |
| order-followup.<<.keycloak.clientId | string | `"${ORDER_KEYCLOAK_CLIENT_ID}"` | Keycloak client ID |
| order-followup.<<.keycloak.clientSecret | string | `"${ORDER_KEYCLOAK_CLIENT_SECRET}"` | Keycloak client secret |
| order-followup.<<.keycloak.enabled | bool | `false` | enable or disable Keycloak integration |
| order-followup.<<.keycloak.url | string | `"https://keycloak"` | Keycloak service URL |
| order-followup.<<.mongo.arbiter.enabled | bool | `false` | enable mongoDB arbiter for replica sets |
| order-followup.<<.mongo.architecture | string | `"standalone"` | mongoDB deployment architecture |
| order-followup.<<.mongo.auth.enabled | bool | `false` | enable mongoDB authentication |
| order-followup.<<.mongo.auth.rootPassword | string | `""` | mongoDB root user password |
| order-followup.<<.mongo.auth.rootUser | string | `"mongo_user"` | mongoDB root user name |
| order-followup.<<.mongo.commonLabels | object | `{"domain":"dbms","productname":"mongodb"}` | labels to add to mongoDB pods and services |
| order-followup.<<.mongo.directoryPerDB | bool | `true` | create a separate directory for each database |
| order-followup.<<.mongo.enabled | bool | `true` | enable or disable mongoDB deployment |
| order-followup.<<.mongo.extraEnvVarsSecret | string | `""` | extra environment variables to set on mongoDB pods from a secret |
| order-followup.<<.mongo.fullnameOverride | string | `""` | scripts to run on mongoDB initialization |
| order-followup.<<.mongo.global.imageRegistry | string | `"registry.hub.docker.com"` | image registry to pull mongoDB images from |
| order-followup.<<.mongo.global.storageClass | string | `"block-default-storage-class"` | storage class to use for mongoDB persistent volume claims |
| order-followup.<<.mongo.image.repository | string | `"bitnamilegacy/mongodb"` | mongoDB image repository |
| order-followup.<<.mongo.initdbScripts | object | `{}` | database initialization scripts |
| order-followup.<<.mongo.metrics.enabled | bool | `true` |  |
| order-followup.<<.mongo.metrics.image.repository | string | `"bitnamilegacy/mongodb-exporter"` | mongoDB exporter image repository |
| order-followup.<<.mongo.podAnnotations | object | `{"prometheus.io/path":"/metrics","prometheus.io/port":"9216","prometheus.io/scrape":"true"}` | enable monitoring and supervision of mongoDB pods |
| order-followup.<<.mongo.resources.limits | object | `{"memory":"1500Mi"}` | resource requests and limits for mongoDB pods |
| order-followup.<<.mongo.service | object | `{"nameOverride":"","ports":{"mongodb":27017}}` | service configuration for mongoDB |
| order-followup.<<.mongo.useStatefulSet | bool | `true` | use statefulset for mongoDB deployment |
| order-followup.<<.monitoring.application | string | `""` | label to specify application name |
| order-followup.<<.monitoring.domain | string | `""` | label for exporter autodetection |
| order-followup.<<.monitoring.environment | string | `""` | label for environment being deployed |
| order-followup.<<.monitoring.productName | string | `"discobole"` | label to specify product name  |
| order-followup.<<.monitoring.role | string | `""` | label to specify role |
| order-followup.<<.monitoring.topology | string | `""` | label to specify topology |
| order-followup.<<.nodeSelector | object | `{}` | node selectorfor pod assignment |
| order-followup.<<.otel.enabled | bool | `false` | activate Open Telemetry instrumentation |
| order-followup.<<.otel.sidecar.collector.host | string | `""` | otlp main collector host (defaults to "otel-collector") |
| order-followup.<<.otel.sidecar.collector.port | int | `14250` | otlp main collector port (defaults to otlp 4317 port on main otel collector) |
| order-followup.<<.otel.sidecar.enabled | bool | `false` | set to true to enable collector agent sidecar |
| order-followup.<<.otel.sidecar.exporter | string | `""` | otlp protocol to use in sidecar exporter (only otlp is available in default config) |
| order-followup.<<.podAnnotations | object | `{}` |  |
| order-followup.<<.podSecurityContext | object | `{}` | enable monitoring and supervision of pods prometheus.io/port: '8080' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' # align with contextPath, if specified remove curly braces and specify if necessary |
| order-followup.<<.registryCredentials.create | bool | `false` | specifies whether a registry credentials secret should be created |
| order-followup.<<.registryCredentials.token.password | string | `""` |  |
| order-followup.<<.registryCredentials.token.userName | string | `""` |  |
| order-followup.<<.registryCredentials.url | string | `""` | example for GitLab internal registry |
| order-followup.<<.replicaCount | int | `1` | application replica count |
| order-followup.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| order-followup.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| order-followup.<<.securityContext | object | `{}` |  |
| order-followup.<<.service.annotations | object | `{}` | enable monitoring and supervision of service |
| order-followup.<<.service.port | int | `8080` | service port |
| order-followup.<<.service.type | string | `"ClusterIP"` | service type |
| order-followup.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| order-followup.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| order-followup.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| order-followup.<<.tolerations | list | `[]` | node tolerations for pod assignment |
| order-followup.fluentd.tag | string | `"order-followup"` |  |
| order-followup.mongo.auth.enabled | bool | `false` | enable mongoDB authentication |
| order-followup.mongo.auth.rootPassword | string | `"${ORDER_FOLLOW_UP_MONGO_PASSWORD}"` | mongoDB root user password |
| order-followup.mongo.auth.rootUser | string | `"mongo_user"` | mongoDB root user name |
| order-followup.mongo.enabled | bool | `true` | enable or disable mongoDB deployment |
| order-followup.mongo.extraEnvVarsSecret | string | `"order-followup-mongo-secret"` | extra environment variables to set on mongoDB pods from a secret |
| order-followup.mongo.fullnameOverride | string | `"order-followup-mongo"` | mongoDB fullname override |
| order-followup.mongo.initdbScripts | object | `{"init.js":"// app user\ndb.getSiblingDB(\"order_follow_up\")\nuse order_follow_up;\ndb.createCollection(\"dummy_table\")\ndb.dummy_table.insertOne({\"desc\" : \"create dummy row to create database\"})\nvar username='mongo_user';\nvar password=process.env[\"MONGO_DB_PWD\"];\nvar user=db.getUser(username);\nif (user == null) {\n  print('create user: ' + username);\n  db.createUser({user: 'mongo_user',pwd: password,roles: [ { role: 'readWrite', db: 'order_follow_up' } ]});\n} else {\n  print('update user: ' + username);\n  db.updateUser(username, {pwd: password});\n}\nprint('---- done for ' + username);\nquit(0);\n"}` | database initialization scripts |
| order-followup.mongo.service.nameOverride | string | `"order-followup-mongo"` |  |
| order-followup.monitoring.application | string | `"order-followup"` |  |
| order-followup.of.service.kafka | string | `"kafka"` | dependent service |
| order-followup.of.service.mxHeap | string | `"805306368"` |  |
| order-followup.of.service.productInventory | string | `"product-inventory"` | dependent service |
| order-inventory.<<.affinity | object | `{}` | node affinity for pod assignment |
| order-inventory.<<.api.contextPath | string | `"/api/v2/"` |  |
| order-inventory.<<.autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| order-inventory.<<.autoscaling.maxReplicas | string | `""` | Maximum number of pod replicas |
| order-inventory.<<.autoscaling.minReplicas | string | `""` | Minimum number of pod replicas |
| order-inventory.<<.autoscaling.targetCPUUtilizationPercentage | string | `""` | Target CPU utilization percentages for pod scaling |
| order-inventory.<<.autoscaling.targetMemoryUtilizationPercentage | string | `""` | Target Memory utilization percentages for pod scaling |
| order-inventory.<<.certManager.create | bool | `false` |  |
| order-inventory.<<.contextPath | string | `""` |  |
| order-inventory.<<.fluentd.enabled | bool | `false` | set to true to enable fluentd logging |
| order-inventory.<<.fluentd.host | string | `""` | hostname of the fluentd instance this application should send logs to. Defaults to localhost |
| order-inventory.<<.fluentd.port | string | `""` | port of the fluentd instance this application should send logs to. Defaults to localhost |
| order-inventory.<<.fluentd.sidecar.enabled | bool | `false` | set to true to enable the fluentd sidecar container |
| order-inventory.<<.fluentd.sidecar.loki | object | `{"extra_labels":"\"env\":\"sandbox\", \"app\": \"disco\"","url":""}` | loki output configuration for the fluentd sidecar |
| order-inventory.<<.fluentd.tag | string | `""` | tag value being set on log events and used by fluentd to route logs |
| order-inventory.<<.imagePullSecrets | list | `[]` | image pull secrets if you use a private registry |
| order-inventory.<<.ingress.annotations | object | `{}` | ingress class annotations |
| order-inventory.<<.ingress.className | string | `""` | ingress class name |
| order-inventory.<<.ingress.enabled | bool | `false` |  |
| order-inventory.<<.ingress.hosts[0] | object | `{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}` | ingress hostnames |
| order-inventory.<<.ingress.tls | list | `[]` |  |
| order-inventory.<<.jdkJavaOptions | string | `""` | extra java options to pass to the jvm |
| order-inventory.<<.keyStoreP12 | string | `""` | base64 encoded p12 keystore file content |
| order-inventory.<<.keycloak.clientId | string | `"${ORDER_KEYCLOAK_CLIENT_ID}"` | Keycloak client ID |
| order-inventory.<<.keycloak.clientSecret | string | `"${ORDER_KEYCLOAK_CLIENT_SECRET}"` | Keycloak client secret |
| order-inventory.<<.keycloak.enabled | bool | `false` | enable or disable Keycloak integration |
| order-inventory.<<.keycloak.url | string | `"https://keycloak"` | Keycloak service URL |
| order-inventory.<<.mongo.arbiter.enabled | bool | `false` | enable mongoDB arbiter for replica sets |
| order-inventory.<<.mongo.architecture | string | `"standalone"` | mongoDB deployment architecture |
| order-inventory.<<.mongo.auth.enabled | bool | `false` | enable mongoDB authentication |
| order-inventory.<<.mongo.auth.rootPassword | string | `""` | mongoDB root user password |
| order-inventory.<<.mongo.auth.rootUser | string | `"mongo_user"` | mongoDB root user name |
| order-inventory.<<.mongo.commonLabels | object | `{"domain":"dbms","productname":"mongodb"}` | labels to add to mongoDB pods and services |
| order-inventory.<<.mongo.directoryPerDB | bool | `true` | create a separate directory for each database |
| order-inventory.<<.mongo.enabled | bool | `true` | enable or disable mongoDB deployment |
| order-inventory.<<.mongo.extraEnvVarsSecret | string | `""` | extra environment variables to set on mongoDB pods from a secret |
| order-inventory.<<.mongo.fullnameOverride | string | `""` | scripts to run on mongoDB initialization |
| order-inventory.<<.mongo.global.imageRegistry | string | `"registry.hub.docker.com"` | image registry to pull mongoDB images from |
| order-inventory.<<.mongo.global.storageClass | string | `"block-default-storage-class"` | storage class to use for mongoDB persistent volume claims |
| order-inventory.<<.mongo.image.repository | string | `"bitnamilegacy/mongodb"` | mongoDB image repository |
| order-inventory.<<.mongo.initdbScripts | object | `{}` | database initialization scripts |
| order-inventory.<<.mongo.metrics.enabled | bool | `true` |  |
| order-inventory.<<.mongo.metrics.image.repository | string | `"bitnamilegacy/mongodb-exporter"` | mongoDB exporter image repository |
| order-inventory.<<.mongo.podAnnotations | object | `{"prometheus.io/path":"/metrics","prometheus.io/port":"9216","prometheus.io/scrape":"true"}` | enable monitoring and supervision of mongoDB pods |
| order-inventory.<<.mongo.resources.limits | object | `{"memory":"1500Mi"}` | resource requests and limits for mongoDB pods |
| order-inventory.<<.mongo.service | object | `{"nameOverride":"","ports":{"mongodb":27017}}` | service configuration for mongoDB |
| order-inventory.<<.mongo.useStatefulSet | bool | `true` | use statefulset for mongoDB deployment |
| order-inventory.<<.monitoring.application | string | `""` | label to specify application name |
| order-inventory.<<.monitoring.domain | string | `""` | label for exporter autodetection |
| order-inventory.<<.monitoring.environment | string | `""` | label for environment being deployed |
| order-inventory.<<.monitoring.productName | string | `"discobole"` | label to specify product name  |
| order-inventory.<<.monitoring.role | string | `""` | label to specify role |
| order-inventory.<<.monitoring.topology | string | `""` | label to specify topology |
| order-inventory.<<.nodeSelector | object | `{}` | node selectorfor pod assignment |
| order-inventory.<<.otel.enabled | bool | `false` | activate Open Telemetry instrumentation |
| order-inventory.<<.otel.sidecar.collector.host | string | `""` | otlp main collector host (defaults to "otel-collector") |
| order-inventory.<<.otel.sidecar.collector.port | int | `14250` | otlp main collector port (defaults to otlp 4317 port on main otel collector) |
| order-inventory.<<.otel.sidecar.enabled | bool | `false` | set to true to enable collector agent sidecar |
| order-inventory.<<.otel.sidecar.exporter | string | `""` | otlp protocol to use in sidecar exporter (only otlp is available in default config) |
| order-inventory.<<.podAnnotations | object | `{}` |  |
| order-inventory.<<.podSecurityContext | object | `{}` | enable monitoring and supervision of pods prometheus.io/port: '8080' prometheus.io/scrape: 'true' metrics: '/actuator/prometheus' # align with contextPath, if specified remove curly braces and specify if necessary |
| order-inventory.<<.registryCredentials.create | bool | `false` | specifies whether a registry credentials secret should be created |
| order-inventory.<<.registryCredentials.token.password | string | `""` |  |
| order-inventory.<<.registryCredentials.token.userName | string | `""` |  |
| order-inventory.<<.registryCredentials.url | string | `""` | example for GitLab internal registry |
| order-inventory.<<.replicaCount | int | `1` | application replica count |
| order-inventory.<<.resources.limits | object | `{"cpu":"","memory":""}` | resource limits |
| order-inventory.<<.resources.requests | object | `{"cpu":"","memory":""}` | resource requests |
| order-inventory.<<.securityContext | object | `{}` |  |
| order-inventory.<<.service.annotations | object | `{}` | enable monitoring and supervision of service |
| order-inventory.<<.service.port | int | `8080` | service port |
| order-inventory.<<.service.type | string | `"ClusterIP"` | service type |
| order-inventory.<<.serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| order-inventory.<<.serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| order-inventory.<<.serviceAccount.name | string | `"${SERVICE_ACCOUNT_NAME}"` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| order-inventory.<<.tolerations | list | `[]` | node tolerations for pod assignment |
| order-inventory.fluentd.tag | string | `"order-inventory"` |  |
| order-inventory.mongo.auth.enabled | bool | `false` | enable mongoDB authentication |
| order-inventory.mongo.auth.rootPassword | string | `"${ORDER_INVENTORY_MONGO_PASSWORD}"` | mongoDB root user password |
| order-inventory.mongo.auth.rootUser | string | `"mongo_user"` | mongoDB root user name |
| order-inventory.mongo.enabled | bool | `true` | enable or disable mongoDB deployment |
| order-inventory.mongo.extraEnvVarsSecret | string | `"order-inventory-mongo-secret"` | extra environment variables to set on mongoDB pods from a secret |
| order-inventory.mongo.fullnameOverride | string | `"order-inventory-mongo"` | mongoDB fullname override |
| order-inventory.mongo.initdbScripts | object | `{"init.js":"// app user\ndb.getSiblingDB(\"order_inventory\")\nuse order_inventory;\ndb.createCollection(\"dummy_table\")\ndb.dummy_table.insertOne({\"desc\" : \"create dummy row to create database\"})\nvar username='mongo_user';\nvar password=process.env[\"MONGO_DB_PWD\"];\nvar user=db.getUser(username);\nif (user == null) {\n  print('create user: ' + username);\n  db.createUser({user: 'mongo_user',pwd: password,roles: [{ role: 'readWrite', db: 'order_inventory' } ]});\n} else {\n  print('update user: ' + username);\n  db.updateUser(username, {pwd: password});\n}\nprint('---- done for ' + username);\nquit(0);\n"}` | database initialization scripts |
| order-inventory.mongo.service | object | `{"nameOverride":"order-inventory-mongo"}` | service configuration for mongoDB |
| order-inventory.monitoring.application | string | `"order-inventory"` |  |
| order-inventory.orderInventory.service.authUserRole | string | `"auth-userrole:8080"` | dependent service |
| order-inventory.orderInventory.service.kafka | string | `"kafka"` | dependent service |
| order-inventory.orderInventory.service.mxHeap | string | `"805306368"` | heap memory setting |
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
$ helm install my-release -f values.yaml discobole/order-component
```

## Docker image access

These values help you to configure access to the Docker image for this microservice.

- if you need to pull the Docker image from a private or protected registry, you have to create and specify an `imagePullSecret`
- if you wish to let the chart create the image pull secret for you, configure the `serviceAccount.imagePullSecret` section

In case you delegate the creation of an image pull secret, use your own credentials on the private or protected registry, as follows.

```bash
$ helm install my-release discobole/order-component \
--set serviceAccount.imagePullSecret.create=true \
--set serviceAccount.imagePullSecret.registry=<your private or protected docker registry> \
--set serviceAccount.imagePullSecret.username=<you username> \
--set serviceAccount.imagePullSecret.password=<your access token>
```
