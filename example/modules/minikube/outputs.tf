output "connection_info" {
  value = {
    host                   = minikube_cluster.cluster.host
    client_certificate     = minikube_cluster.cluster.client_certificate
    client_key             = minikube_cluster.cluster.client_key
    cluster_ca_certificate = minikube_cluster.cluster.cluster_ca_certificate
  }
  sensitive   = true
  description = "The data needed to connect with other kubernetes providers"
}
