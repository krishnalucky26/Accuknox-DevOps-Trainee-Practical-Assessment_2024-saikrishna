Cow wisdom - Accuknox
Problem Statement - 1
Title: Containerization and Deployment of Wisecow Application on Kubernetes
Objective : To containerize and deploy the Wisecow application, hosted in the above-mentioned GitHub repository, on a Kubernetes environment with secure TLS communication. Note: In this deployment we are using local Kubernetes cluster and application will run on localhost.

Create Docker file
Create Docker Image
Deploy container on Kubernetes Environment
Secure TLS communication
Getting Started
To run this project on your local machine, follow these steps:

Installation:
You can install fortune-mod and cowsay on Debian-based systems like Ubuntu using the following commands:

sudo apt update
sudo apt install fortune-mod cowsay -y
Dockerization

Create docker file with the name Dockerfile , navigate to the path of file and execute.

Build the Dockerfile using below command.

docker build -t wisecow-image .
Docker Images

Create repository/ container registry to Dockerhub and push the image with proper tag to it.

docker push _yourRepositoryName_/wisecow_image:latest
Dockerization

Kubernetes Deployment :

Create Kubernetes deployment manifest files for deploying the Wisecow application in a Kubernetes environment. ex : deployment_manifests_kubernetes.yaml
Create service file exposed as a Kubernetes service for accessibility. ex : service_manifests_kubernetes.yaml
Apply the deployment and service using following commands.
kubectl apply -f wisecow-app-deployment.yaml
kubectl apply -f wisecow-app-service.yaml
Check deployments and services running.Use commands.
kubectl get deployments
kubectl get services
Kubernete  Service Deployment

Continuous Integration And Deployment 1.Github workflow for a. Create yaml file in ./github/workflows b. Set the secrets secrets.DOCKER_USERNAME and secrets.DOCKER_PASSWORD with your Dockerhub username and docker image name.

workflow

TLS Implementaion

Install OpenSSL.
sudo apt-get install openssl  
openssl

Generate Private Key.
openssl genrsa -out server.key 2048
Generate Certificate Signing Request (CSR)
openssl req -new -key server.key -out server.csr
Self-Sign Certificate
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
Certificate

Deploy to Kubernetes. Reference this TLS secret in Kubernetes deployment configuration to enable TLS
kubectl create secret tls tls-secret --cert=server.crt --key=server.key
Output WisecowRun
Feel free to customize this README to provide more specific information about your project. Include any additional setup instructions, prerequisites, or specific details about your application that you think would be helpful for users.
