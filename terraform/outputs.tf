output "argocd_server_service" {
  value = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}

output "argocd_password_command" {
  value = "kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 --decode"
}