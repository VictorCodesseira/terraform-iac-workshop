module "s3" {
  source = "../../modules/s3"

  bucket_name = "my-bucket"

  notifications = [
    {
      type = "SNS"
      target_arn     = module.sns.topic_arn
      events        = ["s3:ObjectCreated:*"]
    }
  ]

  force_destroy = true
}

module "sns" {
  source = "../../modules/sns"

  topic_name = "my-topic"
}

module "sqs" {
  source = "../../modules/sqs"

  queue_name = "my-queue"
  dlq_enabled = true

  sns_topic_arn = module.sns.topic_arn
}

module "dynamodb" {
  source = "../../modules/dynamodb"

  table_name = "my-table"
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
  source_file = "static/index.py"
  output_file_mode = "0666"
  output_path = "static/lambda_payload.zip"
}

module "lambda_function" {
  source = "../../modules/lambda_function"

  function_name = "my-function"
  handler = "index.handler"
  runtime = "python3.8"
  payload_file = data.archive_file.lambda.output_path
  environment_variables = {
    DYNAMODB_TABLE = module.dynamodb.table_name
    LOCALSTACK_ENV = "true"
  }

  trigger_arns = [
    module.sqs.queue_arn
  ]
}