#!/bin/bash

echo "Installing Calico"
docker-compose -f ../../docker/docker-compose.yml run --rm kube kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
docker-compose -f ../../docker/docker-compose.yml run --rm kube kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
