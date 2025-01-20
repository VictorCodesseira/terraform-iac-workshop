terraform {
  required_version = "~> 1.7"
  backend "local" {
    path = "terraform.tfstate"
  }
  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "~> 0.4.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    argocd = {
      source  = "argoproj-labs/argocd"
      version = "~> 7.1.0"
    }
  }
}

provider "minikube" {
  kubernetes_version = "v1.30.0"
}

provider "kubernetes" {
  host = module.minikube.connection_info.host

  client_certificate     = module.minikube.connection_info.client_certificate
  client_key             = module.minikube.connection_info.client_key
  cluster_ca_certificate = module.minikube.connection_info.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host = module.minikube.connection_info.host

    client_certificate     = module.minikube.connection_info.client_certificate
    client_key             = module.minikube.connection_info.client_key
    cluster_ca_certificate = module.minikube.connection_info.cluster_ca_certificate
  }
}

provider "argocd" {
  username     = "admin"
  password     = "admin"
  port_forward = true
  kubernetes {
    host = module.minikube.connection_info.host

    cluster_ca_certificate = module.minikube.connection_info.cluster_ca_certificate
  }
}