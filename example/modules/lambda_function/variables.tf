variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "trigger_arns" {
  description = "ARNs of the resources that trigger the Lambda function"
  type        = list(string)
  default     = []
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = null
}

variable "payload_file" {
  description = "Path to the Lambda function payload file"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
}