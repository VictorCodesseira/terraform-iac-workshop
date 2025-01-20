variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "The billing mode for the DynamoDB table"
  type        = string
  default     = "PAY_PER_REQUEST"
  validation {
    condition     = var.billing_mode == "PROVISIONED" || var.billing_mode == "PAY_PER_REQUEST"
    error_message = "billing_mode must be either 'PROVISIONED' or 'PAY_PER_REQUEST'"
  }
}

variable "read_capacity" {
  description = "The number of read units for the DynamoDB table"
  type        = number
  default     = 0
  validation {
    condition     = var.billing_mode == "PROVISIONED"  ? (var.read_capacity > 0) : true
    error_message = "read_capacity must be greater than 0 if billing_mode is 'PROVISIONED'"
  }
}

variable "write_capacity" {
  description = "The number of write units for the DynamoDB table"
  type        = number
  default     = 0
  validation {
    condition     = var.billing_mode == "PROVISIONED"  ? (var.write_capacity > 0) : true
    error_message = "write_capacity must be greater than 0 if billing_mode is 'PROVISIONED'"
  }
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key"
  type        = string
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key"
  type        = string
  default     = null
}

variable "attributes" {
  description = "The attributes of the DynamoDB table"
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "enable_stream" {
  description = "Whether to enable DynamoDB streams"
  type        = bool
  default     = false
}
