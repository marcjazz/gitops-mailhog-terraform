variable "argocd_namespace" {
  default = "argocd"
}

variable "mailhog_namespace" {
  default = "mailhog"
}

variable "argocd_version" {
  default = "5.51.6"
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "github_username" {
  description = "GitHub username for the GitOps repository"
  type        = string
}