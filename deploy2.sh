#!/bin/bash
echo "Starting deploy2.sh script"
echo "Starting minikube"
minikube start --extra-config=apiserver.service-node-port-range=1-65535
sudo apt install snapd
echo "Installing helm"
sudo snap install helm --classic
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install mongo --set usePassword=false,replicaSet.enabled=true,service.type=LoadBalancer,replicaSet.replicas.secondary=3 bitnami/mongodb
sleep 2m
echo "I'm waiting for 2 minutes while mongo is delpoing"
mkdir mern
cd mern
git clone --branch master https://github.com/ShishkoAleksander/minikube.git
cd minikube/
helm install backend server/chart
sleep 2m
echo "I'm waiting for 2 minutes while backend is delpoing"
helm install frontend client/chart
sleep 2m
echo "I'm waiting for 2 minutes while frontend is delpoing"
podname=$(kubectl get pods -o=name |  sed "s/^.\{4\}//" | grep front)
kubectl port-forward --address 0.0.0.0 $podname 3000:3000
echo "End job"
