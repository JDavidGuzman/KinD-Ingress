#!/bin/bash

echo "Configuring MetalLB"
docker-compose -f ../../docker/docker-compose.yml run --rm kube kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
docker-compose -f ../../docker/docker-compose.yml run --rm kube kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
docker-compose -f ../../docker/docker-compose.yml run --rm kube kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
docker-compose -f ../../docker/docker-compose.yml run --rm kube kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
docker-compose -f ../../docker/docker-compose.yml run --rm kube kubectl apply -f LB/cm-ml.yml
