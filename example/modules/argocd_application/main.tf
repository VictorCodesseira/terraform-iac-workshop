terraform {
  required_providers {
    argocd = {
      source  = "argoproj-labs/argocd"
      version = "~> 7.1.0"
    }
  }
}

resource "argocd_application" "app" {
  wait = true
  metadata {
    name      = var.name
  }

  spec {
    source {
      repo_url        = var.app_source.repo_url
      target_revision = var.app_source.target_revision
      path            = var.app_source.path
    }
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = var.namespace
    }
    sync_policy {
      sync_options = ["CreateNamespace=true"]
      dynamic "automated" {
        for_each = var.auto_sync ? [true] : []
        content {
          prune     = true
          self_heal = true
        }
      }
    }
  }
}