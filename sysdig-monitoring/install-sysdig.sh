#!/bin/bash

echo "Adicionando repositório do Sysdig..."
helm repo add sysdig https://charts.sysdig.com
helm repo update

echo "Instalando Sysdig Agent..."
helm install sysdig-agent sysdig/sysdig \
  --namespace sysdig \
  --create-namespace \
  --set sysdig.accessKey=SEU_ACCESS_KEY \
  --set sysdig.settings.collector=collector.sysdigcloud.com \
  --set sysdig.settings.ssl=true \
  --set sysdig.settings.k8sAuditDetections.enabled=true

