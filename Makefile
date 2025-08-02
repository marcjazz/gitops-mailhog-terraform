# Makefile for GitOps Workshop

# Variables
ARGOCD_NAMESPACE := argocd
MAILHOG_NAMESPACE := mailhog

# Targets
.PHONY: all clean help

all: help

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  argocd-install          - Install Argo CD using Terraform"
	@echo "  argocd-password         - Get Argo CD admin password"
	@echo "  argocd-port-forward     - Port-forward Argo CD server"
	@echo "  mailhog-port-forward    - Port-forward Mailhog service"
	@echo "  clean                   - Clean up all resources"

argocd-install:
	@echo "Installing Argo CD with Terraform..."
	cd terraform && terraform init && terraform apply -auto-approve

argocd-password:
	@echo "Getting Argo CD admin password..."
	@kubectl get secret argocd-initial-admin-secret -n $(ARGOCD_NAMESPACE) -o jsonpath="{.data.password}" | base64 --decode

argocd-port-forward:
	@echo "Port-forwarding Argo CD server to https://localhost:8080..."
	@kubectl port-forward svc/argocd-server -n $(ARGOCD_NAMESPACE) 8080:443

mailhog-port-forward:
	@echo "Port-forwarding Mailhog service to http://localhost:8025..."
	@kubectl port-forward svc/mailhog -n $(MAILHOG_NAMESPACE) 8025:8025

clean:
	@echo "Cleaning up resources..."
	cd terraform && terraform destroy -auto-approve
