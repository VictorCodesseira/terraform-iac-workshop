terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  queue_name = var.fifo_queue ? "${var.queue_name}.fifo" : var.queue_name
  dlq_name   = "${var.queue_name}-dlq"
}

resource "aws_sqs_queue" "main" {
  name                       = local.queue_name
  fifo_queue                 = var.fifo_queue
  visibility_timeout_seconds = var.visibility_timeout

  redrive_policy = var.dlq_enabled ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
    maxReceiveCount     = 5
  }) : null

  tags = {
    Name = local.queue_name
  }
}

resource "aws_sqs_queue" "dlq" {
  count = var.dlq_enabled ? 1 : 0

  name       = local.dlq_name
  fifo_queue = var.fifo_queue

  tags = {
    Name = local.dlq_name
  }
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  count = var.sns_topic_arn != null ? 1 : 0

  topic_arn = var.sns_topic_arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.main.arn
}