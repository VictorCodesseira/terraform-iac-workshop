module "minikube" {
  source = "../../modules/minikube"
}

locals {
  argocd_url = "localhost:8080"
}

module "argocd" {
  source = "../../modules/helm_chart"

  release_name  = "argocd"
  repository    = "https://argoproj.github.io/argo-helm"
  namespace     = "argocd"
  chart         = "argo-cd"
  chart_version = "7.0.0"

  set_values = {
    "global.domain" = local.argocd_url
  }
}

data "kubernetes_secret" "argocd_initial_admin_password" {
  depends_on = [module.argocd]

  metadata {
    name     = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
}

output "argocd_password" {
  value = nonsensitive(data.kubernetes_secret.argocd_initial_admin_password.data["password"])
}

module "application" {
  source = "../../modules/argocd_application"

  name      = "example-app"
  namespace = "myapp"
  app_source = {
    repo_url        = "https://github.com/argoproj/argocd-example-apps.git"
    path            = "guestbook"
  }
}