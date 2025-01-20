variable "topic_name" {
  description = "The name of the SNS topic"
  type        = string
}

variable "fifo_topic" {
  description = "Whether the SNS topic is FIFO"
  type        = bool
  default     = false
}

variable "subscriptions" {
  description = "A list of subscriptions to be added to the SNS topic"
  type = list(object({
    protocol = string
    endpoint = string
  }))
  default = []
}