resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = var.argocd_namespace
  version    = var.argocd_version

  # Wait for all Argo CD resources (including CRDs) to be ready
  wait       = true
  values = [
    <<EOF
server:
  service:
    type: NodePort
EOF
  ]
}


# Apply MailHog via Kubernetes provider (removes null_resource)
resource "kubernetes_manifest" "mailhog_app" {
  manifest = yamldecode(templatefile("${path.module}/templates/mailhog-app.yaml.tpl", {
    github_username = var.github_username
  }))
  depends_on = [
    helm_release.argocd,
    kubernetes_namespace.argocd
  ]
}