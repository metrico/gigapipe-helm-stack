{{/*
Check if ClickHouse Keeper should be deployed (shards > 1 OR replicas > 1)
*/}}
{{- define "gigapipe-stack.clickhouse.needsKeeper" -}}
{{- if or (gt (int .Values.clickhouse.shards) 1) (gt (int .Values.clickhouse.replicas) 1) -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}
