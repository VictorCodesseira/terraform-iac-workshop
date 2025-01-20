variable "release_name" {
  description = "Name of the Helm release"
  type        = string
}

variable "repository" {
  description = "Helm chart repository URL"
  type        = string
}

variable "chart" {
  description = "Helm chart name"
  type        = string
}

variable "chart_version" {
  description = "Helm chart version"
  type        = string
}

variable "namespace" {
  type = string
  description = "Namespace to install the Helm chart"
}

variable "set_values" {
  description = "Values to set in the Helm chart"
  type        = map(string)
  default     = {}
}
