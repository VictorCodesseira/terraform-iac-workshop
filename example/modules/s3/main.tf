terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_notification" "this" {
  bucket = aws_s3_bucket.this.bucket

  dynamic "topic" {
    for_each = [ for notification in var.notifications : notification if notification.type == "SNS" ]
    content {
      topic_arn     = topic.value.target_arn
      events        = topic.value.events
      filter_prefix = topic.value.filter_prefix
    }
  }

  dynamic "queue" {
    for_each = [ for notification in var.notifications : notification if notification.type == "SQS" ]
    content {
      queue_arn     = queue.value.target_arn
      events        = queue.value.events
      filter_prefix = queue.value.filter_prefix
    }
  }

  dynamic "lambda_function" {
    for_each = [ for notification in var.notifications : notification if notification.type == "LAMBDA" ]
    content {
      lambda_function_arn     = lambda_function.value.target_arn
      events        = lambda_function.value.events
      filter_prefix = lambda_function.value.filter_prefix
    }
  }
}