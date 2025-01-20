output "s3_arn" {
  value = module.s3.bucket_arn
}

output "dynamodb_arn" {
  value = module.dynamodb.table_arn
}

output "lambda_arn" {
  value = module.lambda_function.lambda_function_arn
}