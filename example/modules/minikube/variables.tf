variable "driver" {
  type        = string
  default     = "qemu2"
  description = "The driver used for the minikube cluster"
}

variable "cluster_name" {
  type        = string
  default     = "minikube-cluster"
  description = "The name of the minikube cluster"
}

variable "extra_addons" {
  type        = list(string)
  default     = []
  description = "Extra addons to enable on the minikube cluster"
}