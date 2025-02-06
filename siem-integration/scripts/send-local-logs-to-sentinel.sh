#!/bin/bash

# Variáveis de configuração
WORKSPACE_ID="<LOG_ANALYTICS_WORKSPACE_ID>"
SHARED_KEY="<LOG_ANALYTICS_SHARED_KEY>"
LOG_FILE="/var/log/kubernetes-audit.log"

# Função para criar assinatura HMAC
build_signature() {
  local DATE=$(date -u +"%a, %d %b %Y %H:%M:%S GMT")
  local STRING_TO_SIGN="POST\n${#PAYLOAD}\napplication/json\nx-ms-date:$DATE\n/api/logs"
  local SIGNATURE=$(echo -n "$STRING_TO_SIGN" | openssl dgst -sha256 -hmac $SHARED_KEY -binary | base64)
  echo "SharedKey $WORKSPACE_ID:$SIGNATURE"
}

# Envia logs para o Azure Sentinel
send_to_sentinel() {
  local PAYLOAD=$(tail -n 50 $LOG_FILE | jq -R -s -c 'split("\n") | map(select(length > 0) | {Log: .})')
  local DATE=$(date -u +"%a, %d %b %Y %H:%M:%S GMT")
  local SIGNATURE=$(build_signature)

  curl -X POST "https://$WORKSPACE_ID.ods.opinsights.azure.com/api/logs?api-version=2016-04-01" \
    -H "Content-Type: application/json" \
    -H "Authorization: $SIGNATURE" \
    -H "x-ms-date: $DATE" \
    -H "Log-Type: KubeAuditLogs" \
    -d "$PAYLOAD"
}

# Monitoramento contínuo
while true; do
  send_to_sentinel
  sleep 60
done

