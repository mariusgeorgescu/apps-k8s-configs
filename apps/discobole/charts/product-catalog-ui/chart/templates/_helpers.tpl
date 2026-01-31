{{/*
Expand the name of the chart.
*/}}
{{- define "product-catalog-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "product-catalog-ui.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "product-catalog-ui.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "product-catalog-ui.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "product-catalog-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "product-catalog-ui.labels" -}}
helm.sh/chart: {{ include "product-catalog-ui.chart" . }}
{{ include "product-catalog-ui.selectorLabels" . }}
{{ include "product-catalog-ui.monitoringLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "product-catalog-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "product-catalog-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: product-catalog-ui
{{- end }}

{{/*
Monitoring labels
*/}}
{{- define "product-catalog-ui.monitoringLabels" -}}
domain: {{ default "appli" .Values.monitoring.domain }}
productname: {{ default "disco" .Values.monitoring.productName }}
setname: {{ include "product-catalog-ui.fullname" . }}
topology: {{ default "none" .Values.monitoring.topology }}
role: {{ default "none" .Values.monitoring.role }}
environment: {{ default "default" .Values.monitoring.environment }}
internal-elasticsearch: 'true'
{{- end }}

{{/*
Shutdown labels
*/}}
{{- define "product-catalog-ui.shutdownLabels" -}}
stoppable: {{ default "none" .Values.dailyshutdown }}
{{- end }}


{{/*
extra fluentd labels for loki
*/}}
{{- define "product-catalog-ui.lokiLabels" -}}
{{- printf "%s , \"instance\": \"%s\", \"name\": \"%s\", \"productname\": \"%s\", \"setname\": \"%s\", \"container_name\": \"product-catalog-ui\"" .Values.fluentd.sidecar.loki.extra_labels .Release.Name (include "product-catalog-ui.name" .) (default .Chart.Name .Values.monitoring.productName) (include "product-catalog-ui.fullname" .) }}
{{- end -}}