variable "name" {
  description = "The name of the ArgoCD application"
  type        = string
}

variable "namespace" {
  description = "The namespace of the ArgoCD application"
  type        = string
}

variable "app_source" {
  description = "The source of the application"
  type = object({
    repo_url        = string
    target_revision = optional(string, "HEAD") # Default to HEAD if not provided
    path            = string
  })
}

variable "auto_sync" {
  description = "Whether to enable automated sync"
  type        = bool
  default     = true
}