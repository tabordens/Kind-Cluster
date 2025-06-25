#!/bin/bash

# Delete old cluster
kind delete cluster --name kind

# Create cluster with Ingress-ready label and port mappings
kind create cluster --name kind --config kind-cluster.yaml

# Build your Flask image
docker build -t localhost/my-flask-app:latest ./K8s-App

# Load the image into the Kind cluster
kind load docker-image localhost/my-flask-app:latest

# Deploy the Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.0/deploy/static/provider/kind/deploy.yaml

# Wait for ingress to be ready
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

# Deploy your app and service
kubectl apply -f ./K8s-App/flask-deploy.yaml
kubectl apply -f ./K8s-App/flask-svc.yaml
kubectl apply -f ./K8s-App/flask-ingress.yaml

# Deploy CoreDNS

docker build -t localhost/coredns-root:latest ./CoreDns
kind load docker-image localhost/coredns-root:latest



kubectl apply -f ./CoreDns/coredns-configmap.yaml
kubectl apply -f ./CoreDns/coredns-deploy.yaml
kubectl apply -f ./CoreDns/coredns-service.yaml
