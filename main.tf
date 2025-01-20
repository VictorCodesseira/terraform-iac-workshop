terraform {
  required_version = "~> 1.7"
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "sqs" {
  source = "./example/modules/sqs"
  queue_name = "my-queue"
  dlq_enabled = true
}