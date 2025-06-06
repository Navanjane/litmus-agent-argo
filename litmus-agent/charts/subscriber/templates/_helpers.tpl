{{/*
Expand the name of the chart.
*/}}
{{- define "subscriber.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "subscriber.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "subscriber.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "subscriber.labels" -}}
helm.sh/chart: {{ include "subscriber.chart" . }}
{{ include "subscriber.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.global.customLabels }}
{{ toYaml .Values.global.customLabels }}
{{- end }}
{{- if .Values.customLabels }}
{{ toYaml .Values.customLabels }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "subscriber.selectorLabels" -}}
litmuschaos.io/app: {{ .Chart.Name }}
app: subscriber
app.kubernetes.io/name: {{ include "subscriber.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common pod annotations
*/}}
{{- define "subscriber.podAnnotations" -}}
{{- if .Values.global.podAnnotations }}
{{ toYaml .Values.global.podAnnotations }}
{{- end }}
{{- if .Values.podAnnotations }}
{{ toYaml .Values.podAnnotations }}
{{- end }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "subscriber.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "subscriber.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
