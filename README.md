# GitOps Workshop: Deploy Mailhog with Argo CD and Terraform

## ✅ Overview
This project demonstrates **GitOps principles** using:
- **Terraform** to provision Argo CD on Kubernetes
- **Argo CD** to deploy a Mailhog service from Git
- **Kustomize** for environment-based configurations

---

## ✅ Prerequisites
- Kubernetes cluster (Minikube, k3s, or remote)
- `kubectl`, `terraform`, `argocd` CLI installed
- GitHub account for hosting the repo
- Basic knowledge of Git, Kubernetes, and YAML

---

## ✅ Repository Structure
```

terraform/       -> Terraform code to install Argo CD
manifests/       -> K8s manifests for Mailhog (Kustomize)
argocd-apps/     -> Argo CD application definition

```

---

## ✅ Step 1: Install Argo CD with Terraform
Navigate to the terraform folder:
```bash
cd terraform
terraform init
terraform apply -auto-approve
```

This will:

* Create the `argocd` namespace
* Install Argo CD using Helm

---

## ✅ Step 2: Get Argo CD Admin Password

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
```

---

## ✅ Step 3: Login to Argo CD

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Open: `https://localhost:8080`

Username: `admin`
Password: (from previous step)

---

## ✅ Step 4: Create Mailhog Namespace

```bash
kubectl create namespace mailhog
```

---

## ✅ Step 5: Push Manifests to Git

Ensure you commit `manifests/` and `argocd-apps/` to GitHub.

---

## ✅ Step 6: Apply Argo CD Application

```bash
kubectl apply -f argocd-apps/mailhog-app.yaml
```

---

## ✅ Step 7: Access Mailhog

Forward the Mailhog service:

```bash
kubectl port-forward svc/mailhog -n mailhog 8025:8025
```

Open: `http://localhost:8025`

---

## ✅ Bonus Tasks

* Add `prod` overlay and test multi-environment deployment
* Use Helm instead of raw manifests for Mailhog
* Integrate Sealed Secrets or SOPS for secret management

---

## ✅ Clean Up

```bash
terraform destroy -auto-approve
kubectl delete ns mailhog
```

Happy GitOps! 🚀