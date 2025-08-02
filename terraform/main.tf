resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}

resource "kubernetes_namespace" "mailhog" {
  metadata {
    name = var.mailhog_namespace
  }
}