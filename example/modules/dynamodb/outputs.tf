output "table_arn" {
  value = aws_dynamodb_table.dynamodb_table.arn
}

output "table_name" {
  value = aws_dynamodb_table.dynamodb_table.name
}

output "stream_arn" {
  value = var.enable_stream ? aws_dynamodb_table.dynamodb_table.stream_arn : null
}