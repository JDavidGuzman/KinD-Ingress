#!/bin/bash

NAME=$1

kind create cluster --name $NAME --config config.yml
bash LB/metalLB.sh
bash Ingress/nginx.sh