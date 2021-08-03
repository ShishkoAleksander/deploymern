#!/bin/bash
echo "Starting deploy1.sh script"
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
echo "Installing kubectl"
sudo apt-get update
sudo apt-get install -y kubectl
echo "Installing docker"
sudo apt-get update -y && sudo apt-get install -y docker.io
sudo systemctl enable docker
echo "Downloading and installing docker"
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mkdir -p /usr/local/bin
sudo install minikube /usr/local/bin/
sudo usermod -aG docker $USER
newgrp docker
echo "Please, run deploy2.sh script"