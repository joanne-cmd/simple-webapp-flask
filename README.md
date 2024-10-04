# Simple Flask Web App Deployment

## Project Summary

This project demonstrates the deployment of a simple Flask web application using **Docker** and **Kubernetes**. The API serves as a lightweight web server that responds to HTTP requests, making it suitable for microservice architectures. By leveraging **Docker**, the application is containerized to ensure consistent environments across different deployment stages. Additionally, **Kubernetes** is utilized for orchestrating the deployment, scaling, and management of the containerized application, providing high availability and reliability.

### API Functionality

The Flask API is designed to handle basic web requests, offering endpoints for interacting with users or retrieving data. It is built to be scalable and efficient, making it suitable for integration into larger applications or microservices.

### Getting Started
1. Fork then clone the repository
2. step up Docker and Kubernetes
   ensure there are well installed to avoid complication
3. Configure your github secrets, in the setting add  secret for DOCKER_USERNAME  and DOCKER_PASSWORD

### Containerization

The API was containerized using Docker. The Dockerfile defines the environment in which the Flask application runs, including dependencies and configuration settings. The image is built with the following command:

```bash
docker build -t joannetich/simple-webapp-flask:latest .

```
The docker build command creates the  image Docker image 

### CICD Process
The CI/CD pipepline is implemented using Github Actions, it automates the buid test and deployment processes .the work flow has two jobs:
  ### 1. Build job
    build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to Docker Hub
        uses: docker/login-action@v3

        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build Docker image
        run: |
          docker build -t joannetich/simple-webapp-flask:latest .
          docker push joannetich/simple-webapp-flask:latest

 The code is checked out from the repository.

 Docker Buildx is set up to facilitate multi-platform builds.

 Authentication with Docker Hub is performed using secret credentials.

 The Docker image is built and pushed to Docker Hub.
### 2.Deploy job
  The code is checked out again to ensure the latest version is deployed.
  
  A Kubernetes cluster is created using Kind (Kubernetes in Docker).
  
  The Docker image is loaded into the Kind cluster.
  
  Kubernetes manifests (defined in the k8s/flask-deployment.yaml file) are used to deploy the application.

### Deployment on Kubernetes
For this application it has been deployed on a Kind cluster, which helps to access the kubernetes environment locally.
The process involved the following steps:

  Creating a Kubernetes Deployment to manage the application pods.
    
   Exposing the application using a Service, allowing internal communication within the cluster.
   
   Implementing a Network Policy to control traffic to and from the application.
   
   Finaly ensuring secure communication by seting the security application


### Security measures in the application

Security Measures:

RunAsUser and RunAsGroup: The application runs with a non-root user (UID 1000) and group (GID 3000) to minimize security risks.

Network Policies: A Kubernetes Network Policy restricts traffic, allowing only specified ingress and egress communications. This ensures that the application can only be accessed by allowed services and namespaces, reducing the attack surface.

### MakeFile
The application has a makefile to help with the common development task such as making it easier to build, run, and manage the application
### Makefile Usage

#### 1. To build the docker image:
      make build
#### 2. To run the application locally:
      make run
#### 3. To deploy the application to Kubernetes:
      make deploy
#### 4. To run the whole file
      make all
#### 5. To clean up the kind cluster
      make clean

while running the make command  make sure you use the permissions " sudo"


   

