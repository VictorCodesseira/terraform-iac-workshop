
module "s3" {
  source = "../s3"

  bucket_name = var.bucket_name

  notifications = [
    {
      type = "LAMBDA"
      target_arn     = module.lambda_function.lambda_function_arn
      events        = ["s3:ObjectCreated:*"]
    }
  ]

  force_destroy = true
}

module "dynamodb" {
  source = "../dynamodb"

  table_name = "${var.bucket_name}-index-table"
  hash_key = "file_key"

  attributes = [
    {
      name = "file_key"
      type = "S"
    }
  ]
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/static/main.py"
  output_file_mode = "0666"
  output_path = "${path.module}/static/lambda_payload.zip"
}

module "lambda_function" {
  source = "../lambda_function"

  function_name = "${var.bucket_name}-index-function"
  handler = "main.handler"
  runtime = "python3.8"
  payload_file = data.archive_file.lambda.output_path
  environment_variables = {
    DYNAMODB_TABLE = module.dynamodb.table_name
    LOCALSTACK_ENV = "true"
  }
}