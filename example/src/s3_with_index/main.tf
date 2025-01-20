module "s3_with_index" {
  source = "../../modules/s3_with_dynamo_index"

  bucket_name = "my-new-bucket"
}