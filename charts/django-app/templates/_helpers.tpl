{{- define "django-app.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "django-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
