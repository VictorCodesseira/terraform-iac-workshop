output "queue_url" {
  value = aws_sqs_queue.main.url
}

output "queue_arn" {
  value = "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${local.queue_name}"
}

output "dlq_url" {
  value = var.dlq_enabled ? aws_sqs_queue.dlq[0].url : null
}

output "dlq_arn" {
  value = var.dlq_enabled ? aws_sqs_queue.dlq[0].arn : null
}