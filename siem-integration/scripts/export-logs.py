import requests
import json
import time

# Configurações
workspace_id = "<LOG_ANALYTICS_WORKSPACE_ID>"
splunk_url = "<SPLUNK_HEC_URL>"
splunk_token = "<SPLUNK_HEC_TOKEN>"
azure_token = "<AZURE_AD_TOKEN>"

# KQL Query para filtrar logs
query = "KubeAuditLogs | where Level == 'Error' | project TimeGenerated, Message, PodName"

# Função para buscar logs do Log Analytics
def fetch_logs():
    url = f"https://api.loganalytics.io/v1/workspaces/{workspace_id}/query"
    headers = {"Authorization": f"Bearer {azure_token}"}
    params = {"query": query}
    response = requests.get(url, headers=headers, params=params)
    return response.json()

# Função para enviar logs para Splunk
def send_to_splunk(logs):
    headers = {
        "Authorization": f"Splunk {splunk_token}",
        "Content-Type": "application/json"
    }
    response = requests.post(splunk_url, headers=headers, data=json.dumps(logs))
    return response.status_code

# Coleta contínua
while True:
    logs = fetch_logs()
    if logs:
        print("Logs fetched, sending to Splunk...")
        status = send_to_splunk(logs)
        print(f"Splunk Response: {status}")
    time.sleep(60)

