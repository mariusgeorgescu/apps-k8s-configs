{{/*
Expand the name of the chart.
*/}}
{{- define "orchestration-delivery-component.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "orchestration-delivery-component.fullname" -}}
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
{{- define "orchestration-delivery-component.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "orchestration-delivery-component.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "orchestration-delivery-component.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "orchestration-delivery-component.labels" -}}
helm.sh/chart: {{ include "orchestration-delivery-component.chart" . }}
{{ include "orchestration-delivery-component.selectorLabels" . }}
{{ include "orchestration-delivery-component.monitoringLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "orchestration-delivery-component.selectorLabels" -}}
app.kubernetes.io/name: {{ include "orchestration-delivery-component.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}



{{/*
Monitoring labels
*/}}
{{- define "orchestration-delivery-component.monitoringLabels" -}}
application: {{ default "orchestration-delivery-component" .Values.monitoring.application }}
domain: {{ default "appli" .Values.monitoring.domain }}
productname: {{ default "disco" .Values.monitoring.productName }}
setname: {{ include "orchestration-delivery-component.fullname" . }}
topology: {{ default "none" .Values.monitoring.topology }}
role: {{ default "none" .Values.monitoring.role }}
environment: {{ default "default" .Values.monitoring.environment }}
internal-elasticsearch: 'true'
{{- end }}


{{/*
extra fluentd labels for loki
*/}}
{{- define "orchestration-delivery-component.lokiLabels" -}}
{{- printf "%s , \"instance\": \"%s\", \"name\": \"%s\", \"productname\": \"%s\", \"setname\": \"%s\", \"container_name\": \"disco-orchestration-delivery-component\"" .Values.fluentd.sidecar.loki.extra_labels .Release.Name (include "orchestration-delivery-component.name" .) (default .Chart.Name .Values.monitoring.productName) (include "orchestration-delivery-component.fullname" .) }}
{{- end -}}

{{/*
Shutdown labels
*/}}
{{- define "orchestration-delivery-component.shutdownLabels" -}}
stoppable: {{ default "none" .Values.dailyshutdown }}
{{- end }}