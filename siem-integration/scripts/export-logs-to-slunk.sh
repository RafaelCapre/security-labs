#!/bin/bash

# Variáveis de configuração
WORKSPACE_ID="<LOG_ANALYTICS_WORKSPACE_ID>"
SPLUNK_URL="<SPLUNK_HEC_URL>"
SPLUNK_TOKEN="<SPLUNK_HEC_TOKEN>"
AZURE_TOKEN="<AZURE_AD_TOKEN>"

# Consulta KQL para filtrar logs do AKS
QUERY="KubeAuditLogs | where Level == 'Error' | project TimeGenerated, Message, PodName"

# Busca logs no Log Analytics via API
echo "Fetching logs from Azure Log Analytics..."
LOGS=$(curl -s -X GET "https://api.loganalytics.io/v1/workspaces/$WORKSPACE_ID/query" \
  -H "Authorization: Bearer $AZURE_TOKEN" \
  --data-urlencode "query=$QUERY")

if [[ -z "$LOGS" ]]; then
  echo "No logs found or failed to fetch logs."
  exit 1
fi

# Envia logs para Splunk via HEC
echo "Sending logs to Splunk..."
curl -X POST $SPLUNK_URL \
  -H "Authorization: Splunk $SPLUNK_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$LOGS"

echo "Logs sent to Splunk successfully."

