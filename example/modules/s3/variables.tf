variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "notifications" {
  description = "A list of SNS topics to send notifications to"
  type = list(object({
    type          = string
    target_arn    = string
    events        = list(string)
    filter_prefix = optional(string)
  }))
}

variable "force_destroy" {
  description = "A boolean flag to enable/disable force destroy"
  type        = bool
  default     = false
}