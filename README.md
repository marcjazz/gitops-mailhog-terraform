# GitOps Workshop: Deploy Mailhog with Argo CD and Terraform

This project demonstrates how to implement GitOps principles to deploy a Mailhog service on Kubernetes. We use Terraform to provision Argo CD, which then synchronizes and deploys the Mailhog application from a Git repository. Kustomize is used for managing environment-specific configurations.

## 📜 Table of Contents

- [✅ Overview](#-overview)
- [✅ Prerequisites](#-prerequisites)
- [✅ Repository Structure](#-repository-structure)
- [✅ Installation](#-installation)
- [✅ Makefile Commands](#-makefile-commands)
- [✅ Clean Up](#-clean-up)
- [✅ Contributing](#-contributing)
- [✅ License](#-license)

---

## ✅ Overview

This project provides a hands-on guide to deploying applications using a GitOps workflow. The key components are:

- **Terraform**: To automate the provisioning of Argo CD on a Kubernetes cluster.
- **Argo CD**: To continuously monitor the Git repository and deploy the Mailhog service.
- **Kustomize**: To manage different configurations for `dev` and `prod` environments.

---

## ✅ Prerequisites

Before you begin, ensure you have the following installed:

- A running Kubernetes cluster (e.g., Minikube, k3s, or a cloud-based cluster).
- The following command-line tools:
  - `kubectl`
  - `terraform`
  - `argocd`
- A GitHub account to host your forked repository.
- Basic understanding of Git, Kubernetes, and YAML.

---

## ✅ Repository Structure

The repository is organized as follows:

```
.
├── manifests/       # Kubernetes manifests for Mailhog (Kustomize)
│   ├── base/        # Base configuration for Mailhog
│   └── overlays/    # Environment-specific overlays (dev, prod)
└── terraform/       # Terraform code to install Argo CD
```

---

## ✅ Installation

Follow these steps to get your Mailhog service up and running:

### Step 1: Install Argo CD with Terraform

Navigate to the `terraform` directory and initialize Terraform:

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

This command will set up the `argocd` namespace and install Argo CD using its official Helm chart.

### Step 2: Get Argo CD Admin Password

Retrieve the initial admin password for the Argo CD UI:

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
```

### Step 3: Log in to Argo CD

Forward the Argo CD server port to your local machine:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Open your browser and navigate to `https://localhost:8080`. Log in with:
- **Username**: `admin`
- **Password**: (from the previous step)

### Step 4: Push Manifests to Git

Commit and push the `manifests/` directory to your GitHub repository. This is a crucial step in the GitOps workflow, as Argo CD will synchronize with this repository to deploy Mailhog.

### Step 5: Access Mailhog

Forward the Mailhog service port to your local machine:

```bash
kubectl port-forward svc/mailhog -n mailhog 8025:8025
```

Open `http://localhost:8025` in your browser to access the Mailhog UI.

---

## ✅ Makefile Commands

To simplify the deployment process, you can use the provided `Makefile`:

- `make argocd-install`: Installs Argo CD using Terraform.
- `make argocd-password`: Retrieves the Argo CD admin password.
- `make argocd-port-forward`: Forwards the Argo CD server port.
- `make mailhog-port-forward`: Forwards the Mailhog service port.
- `make mailhog-port-forward`: Forwards the Mailhog service port.
- `make clean`: Destroys the Terraform-managed infrastructure and deletes the Mailhog namespace.

---

## ✅ Clean Up

To remove all the resources created during this workshop, run the following command from the `terraform` directory:

```bash
terraform destroy -auto-approve
```

Alternatively, you can use the `make clean` command from the root directory.

---

## ✅ Contributing

Contributions are welcome! If you have any suggestions or find any issues, please open an issue or submit a pull request.

---

## ✅ License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Happy GitOps! 🚀