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

resource "aws_sns_topic" "this" {
  name       = var.fifo_topic ? "${var.topic_name}.fifo" : var.topic_name
  fifo_topic = var.fifo_topic
}

resource "aws_sns_topic_subscription" "this" {
  count = length(var.subscriptions)

  topic_arn = aws_sns_topic.this.arn
  protocol  = var.subscriptions[count.index].protocol
  endpoint  = var.subscriptions[count.index].endpoint
}

