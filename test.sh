#!/bin/bash
gcloud config set project cisc5500-345201
gcloud compute instances delete cisc5550-api
gcloud compute firewall-rules delete rule-allow-tcp-8080
gcloud compute firewall-rules delete rule-allow-tcp-8081

gcloud compute instances create cisc5550-api --machine-type n1-standard-1 --image-family debian-9 --image-project debian-cloud --tags http-server --metadata-from-file startup-script=./startup.sh
gcloud compute firewall-rules create rule-allow-tcp-5001 --source-ranges * --target-tags http-server --allow tcp:8080
gcloud compute firewall-rules create rule-allow-tcp-5001 --source-ranges * --target-tags http-server --allow tcp:8081


export TODO_API_IP=`gcloud compute instances list --filter="name=cisc5550-api" --format="value(EXTERNAL_IP)"`

# next, deploy the app that depens on api
docker login
docker build -t bengoodheart/webapp-test --build-arg api_ip=${TODO_API_IP} .


docker build -t bengoodheart/webapp-test

gcloud container clusters create cisc5550-cluster
kubectl create deployment cc5550 --image=bengoodheart/webapp-test --port=8080
kubectl expose deployment cc5550 --type="LoadBalancer"

kubectl get service cc5550
