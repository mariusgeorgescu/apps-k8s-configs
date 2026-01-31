{{/*
Expand the name of the chart.
*/}}
{{- define "order-component.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "order-component.fullname" -}}
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
{{- define "order-component.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "order-component.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "order-component.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "order-component.labels" -}}
helm.sh/chart: {{ include "order-component.chart" . }}
{{ include "order-component.selectorLabels" . }}
{{ include "order-component.monitoringLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "order-component.selectorLabels" -}}
app.kubernetes.io/name: {{ include "order-component.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}



{{/*
Monitoring labels
*/}}
{{- define "order-component.monitoringLabels" -}}
application: {{ default "order-component" .Values.monitoring.application }}
domain: {{ default "appli" .Values.monitoring.domain }}
productname: {{ default "disco" .Values.monitoring.productName }}
setname: {{ include "order-component.fullname" . }}
topology: {{ default "none" .Values.monitoring.topology }}
role: {{ default "none" .Values.monitoring.role }}
environment: {{ default "default" .Values.monitoring.environment }}
internal-elasticsearch: 'true'
{{- end }}


{{/*
extra fluentd labels for loki
*/}}
{{- define "order-component.lokiLabels" -}}
{{- printf "%s , \"instance\": \"%s\", \"name\": \"%s\", \"productname\": \"%s\", \"setname\": \"%s\", \"container_name\": \"disco-order-component\"" .Values.fluentd.sidecar.loki.extra_labels .Release.Name (include "order-component.name" .) (default .Chart.Name .Values.monitoring.productName) (include "order-component.fullname" .) }}
{{- end -}}

{{/*
Shutdown labels
*/}}
{{- define "order-component.shutdownLabels" -}}
stoppable: {{ default "none" .Values.dailyshutdown }}
{{- end }}