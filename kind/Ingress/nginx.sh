#!/bin/bash

echo "Deploy Ingress Controller"
docker-compose -f ../../docker/docker-compose.yml run --rm kube kubectl create ns ingress-nginx
# helm repo update
docker-compose -f ../../docker/docker-compose.yml run --rm kube helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx
docker-compose -f ../../docker/docker-compose.yml run --rm kube kubectl patch -n ingress-nginx deploy ingress-nginx-controller --type merge --patch-file='Ingress/patch.yml'