# Variables
DOCKER_IMAGE = joannetich/simple-webapp-flask:latest
K8S_MANIFEST = k8s/flask-deployment.yaml

# Default target (help text)
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  build           - Build the Docker image"
	@echo "  push            - Push Docker image to Docker Hub"
	@echo "  kind-cluster    - Create Kind cluster"
	@echo "  load-image      - Load Docker image into Kind cluster"
	@echo "  deploy          - Deploy to Kubernetes"
	@echo "  all             - Build, push, and deploy"

# Build the Docker image
.PHONY: build
build:
	@echo "Building Docker image..."
	docker build -t $(DOCKER_IMAGE) .

# Push the Docker image to Docker Hub
.PHONY: push
push: build
	@echo "Pushing Docker image to Docker Hub..."
	docker push $(DOCKER_IMAGE)

# Create a Kind cluster (with cleanup)
.PHONY: kind-cluster
kind-cluster:
	@echo "Deleting existing Kind cluster (if any)..."
	kind delete cluster --name kind || true
	@echo "Creating Kind cluster..."
	kind create cluster --name kind

# Load the Docker image into Kind
.PHONY: load-image
load-image: kind-cluster
	@echo "Loading Docker image into Kind cluster..."
	kind load docker-image $(DOCKER_IMAGE) --name kind

# Deploy the app to Kubernetes
.PHONY: deploy
deploy:
	@echo "Deploying to Kubernetes..."
	kubectl apply -f $(K8S_MANIFEST)

# Build, push, load, and deploy all in one command
.PHONY: all
all: push load-image deploy
	@echo "All tasks completed successfully."
