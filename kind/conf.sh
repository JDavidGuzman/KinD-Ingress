#!/bin/bash

kind create cluster --name kindname --config config.yml
bash CNI/calico.sh
bash LB/metalLB.sh
bash Ingress/nginx.sh

watch kubectl get po --all-namespaces