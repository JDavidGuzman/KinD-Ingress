# KinD and Ingress

This repository presents an example of how to recreate a Kubernetes in Docker environment using Ingress for name-based virtual hosting. For this; Docker, KinD, Kubectl, and Helm are required. For Kubectl and Helm, it will be included a docker folder in order to build a docker image with this utilities.

On the kind folder, can be found a KinD YAML configuration file, prepared to set up a master and worker node, and the necessary configuration for the second one, that will make available to the host the 80 and 443 ports as well as the respective routes for hostPath volumes for Jenkins and Gitlab. Besides this, it can be found some Bash files that will guide the cluster setup steps in order to install calico as the Calico CNI (if needed), MetalLB as the load balancer, and Nginx Ingress Controller that includes a YAML patch in order to bind the HTTP and HTTPS ports on the node.

## Helpful Commands

In order to apply the Ingress Controller patch: 

    kubectl patch -n ingress-nginx deploy ingress-nginx-controller --type merge --patch-file='patch.yml'

To obtain the Gateway IP on the kind docker network (notice the use of jq), with the purpose to configure the address pool for the MetalLB load balancer:

    docker inspect kind --format  '{{json .IPAM.Config}}' | jq .[0].Gateway 

To obtain the worker node ip; this will be useful for the Ingress configuration along with nip.io utility:

    kubectl get node kindname-worker -o=jsonpath='{.status.addresses[0].address}'

# Kustomize, Jenkins and Gitlab

In the kubernetes folder, it is included an Ingress YAML using the nip.io service and the setup for Jenkins and Gitlab, each on its folder using Kustomize workflow for Kubernetes. It contains the necessary Service Account and Role in order to run Jenkins Slaves as Pods on the cluster. Also in the jenkins-jobs folder, can be found an example of a Jenkins Job configuration using JJB builder template, which can be run as a container using the docker-compose file. JJB needs a INI configuration as indicated by the documentation. An example of a bash using the Jenkins crumb feature in order to run jobs remotely is also included.

## Kubernetes Jenkins Plugin

It is recommended to install Kubernetes plugins on Jenkins. In order to allow communication between master and slaves, jenkins tunnel configuration should be established as the IP of the clusterIP service on port 50000.