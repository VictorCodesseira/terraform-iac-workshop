module "minikube" {
  source = "../../modules/minikube"

  extra_addons = ["metrics-server"]
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
    "configs.secret.argocdServerAdminPassword" = "$2y$10$zbDMnn5E2.Pw5mm853Jdj./KMHkG99y4zve7G3pQYVy9EyjXvoqvu"
  }
}

module "application" {
  source = "../../modules/argocd_application"
  depends_on = [module.argocd]

  name      = "cpu-stressor"
  namespace = "iac-workshop"
  app_source = {
    repo_url        = "https://github.com/VictorCodesseira/terraform-iac-workshop.git"
    path            = "example/manifests/application"
  }

  auto_sync = false
}