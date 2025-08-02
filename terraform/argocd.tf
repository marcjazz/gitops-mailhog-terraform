resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = var.argocd_namespace
  version    = var.argocd_version

  values = [
    <<EOF
server:
  service:
    type: NodePort
EOF
  ]
}

# Template the ArgoCD application YAML
data "template_file" "mailhog_app" {
  template = file("${path.module}/templates/mailhog-app.yaml.tpl")
  vars = {
    github_username = var.github_username
  }
}

# Apply the ArgoCD application
resource "kubernetes_manifest" "mailhog_app" {
  manifest = yamldecode(data.template_file.mailhog_app.rendered)
  
  depends_on = [
    helm_release.argocd,
    kubernetes_namespace.argocd
  ]
}