apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: mailhog
  namespace: argocd
spec:
  project: default
  source:
    repoURL: "https://github.com/${github_username}/gitops-mailhog-terraform.git"
    targetRevision: HEAD
    path: manifests/overlays/dev
  destination:
    server: "https://kubernetes.default.svc"
    namespace: mailhog
  syncPolicy:
    automated:
      prune: true
      selfHeal: true