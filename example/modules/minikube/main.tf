terraform {
  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "~> 0.4.3"
    }
  }
}

resource "minikube_cluster" "cluster" {
  driver       = var.driver
  cluster_name = var.cluster_name
  addons = distinct(concat([
    "default-storageclass",
    "storage-provisioner"
  ], var.extra_addons))
  network = var.driver == "qemu2" ? "socket_vmnet" : null
}