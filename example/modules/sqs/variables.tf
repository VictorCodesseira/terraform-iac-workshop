variable "queue_name" {
  description = "The name of the SQS queue"
  type        = string
}

variable "fifo_queue" {
  description = "Boolean to determine if the queue is FIFO"
  type        = bool
  default     = false
}

variable "dlq_enabled" {
  description = "Boolean to determine if a dead-letter queue is enabled"
  type        = bool
  default     = false
}

variable "max_receive_count" {
  description = "The maximum number of times a message can be received before being sent to the dead-letter queue"
  type        = number
  default     = 5
}

variable "visibility_timeout" {
  description = "The visibility timeout for the SQS queue"
  type        = number
  default     = 30
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic to subscribe to"
  type        = string
  default     = null
}