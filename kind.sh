#!/bin/bash
echo "[.] Setup Kind Cluster"
kind create cluster --name main --config kind.yml

echo "[.] Setup Ingress Controller"
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx -f ingress-nginx.yml --create-namespace --namespace ingress-nginx \
	--set controller.setAsDefaultIngress=true \
	--set controller.metrics.enabled=true \
	--set controller.service.httpsPort.enable=false \
	--set controller.service.httpPort.enable=true \
	--set controller.service.httpPort.port=80 \
	--set-string controller.podAnnotations."prometheus\.io/create"="true" \
	--set-string controller.podAnnotations."prometheus\.io/scrape"="true" \
	--set-string controller.podAnnotations."prometheus\.io/port"="10254" \
	--set-string controller.podAnnotations."prometheus\.io/scheme"="http" \
	--set-string controller.podAnnotations."prometheus\.io/path"="/metrics"
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

# Prometheus
echo "[.] Setup Prometheus"
kubectl apply --kustomize github.com/kubernetes/ingress-nginx/deploy/prometheus

# Echo
echo "[.] Setup Echo"
kubectl create ns echo
kubectl apply -f echo.yaml --namespace=echo