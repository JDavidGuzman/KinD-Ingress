#!/bin/bash

echo "Deploy Ingress Controller"
kubectl create ns ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx
kubectl patch -n ingress-nginx deploy ingress-nginx-controller --type merge --patch-file='Ingress/patch.yml'