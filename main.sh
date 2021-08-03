#!/bin/bash
chmod +x deploy1.sh
chmod +x deploy2.sh
nohup ./deploy1.sh &&
nohup ./deploy2.sh
echo "I'm waiting for 2 minutes while frontend is delpoing"
podname=$(kubectl get pods -o=name |  sed "s/^.\{4\}//" | grep front)
kubectl port-forward --address 0.0.0.0 $podname 3000:3000
echo "End job"
