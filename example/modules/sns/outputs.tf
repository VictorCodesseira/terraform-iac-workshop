output "topic_arn" {
  description = "The ARN of the SNS topic"
  value       = "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.topic_name}"
}

output "topic_name" {
  description = "The name of the SNS topic"
  value       = aws_sns_topic.this.name
}