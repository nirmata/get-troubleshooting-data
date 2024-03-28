#!/bin/bash

tag=$1

docker build -t sagarkundral/my-python-app:${tag} -f Dockerfile-new .
docker push sagarkundral/my-python-app:${tag}

kubectl delete cpol --all
#kubectl apply -f /mnt/c/Users/Sagar/Downloads/infosys/generate-policy.yaml

#kubectl -n abc patch pod nginx-pod -p "{\"metadata\":{\"labels\":{\"randomLabel\":\"$(openssl rand -hex 3)\"}}}"


