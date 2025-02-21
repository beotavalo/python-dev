# Variables
DOCKER_IMAGE_NAME = todo-app
DOCKER_IMAGE_TAG = latest
KUBE_NAMESPACE = todo-app
TERRAFORM_DIR = infrastructure

# Docker Commands
build:
	@echo "Building Docker image..."
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

run:
	@echo "Running Docker container..."
	docker run -p 80:80 $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

# Kubernetes Commands
kube-apply:
	@echo "Applying Kubernetes manifests..."
	kubectl apply -f kubernetes/ -n $(KUBE_NAMESPACE)

kube-delete:
	@echo "Deleting Kubernetes resources..."
	kubectl delete -f kubernetes/ -n $(KUBE_NAMESPACE)

kube-status:
	@echo "Checking Kubernetes pod status..."
	kubectl get pods -n $(KUBE_NAMESPACE)

# Terraform Commands
tf-init:
	@echo "Initializing Terraform..."
	cd $(TERRAFORM_DIR) && terraform init

tf-plan:
	@echo "Creating Terraform execution plan..."
	cd $(TERRAFORM_DIR) && terraform plan

tf-apply:
	@echo "Applying Terraform configuration..."
	cd $(TERRAFORM_DIR) && terraform apply -auto-approve

tf-destroy:
	@echo "Destroying Terraform-managed infrastructure..."
	cd $(TERRAFORM_DIR) && terraform destroy -auto-approve

# Combined Commands
deploy: build tf-apply kube-apply
	@echo "Deployment complete!"

clean: kube-delete tf-destroy
	@echo "Cleanup complete!"

# Help Command
help:
	@echo "Available commands:"
	@echo "  build               - Build the Docker image"
	@echo "  run                 - Run the Docker container"
	@echo "  kube-apply          - Apply Kubernetes manifests"
	@echo "  kube-delete         - Delete Kubernetes resources"
	@echo "  kube-status         - Check Kubernetes pod status"
	@echo "  tf-init             - Initialize Terraform"
	@echo "  tf-plan             - Create Terraform execution plan"
	@echo "  tf-apply            - Apply Terraform configuration"
	@echo "  tf-destroy          - Destroy Terraform-managed infrastructure"
	@echo "  deploy              - Build, apply Terraform, and deploy to Kubernetes"
	@echo "  clean               - Clean up Kubernetes and Terraform resources"
	@echo "  help                - Show this help message"
