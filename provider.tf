provider "aws" {
  access_key = "test"
  region     = "us-east-1"
  secret_key = "test"

  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway = var.aws_url
    cloudwatch = var.aws_url
    dynamodb   = var.aws_url
    ec2        = var.aws_url
    iam        = var.aws_url
    lambda     = var.aws_url
    logs       = var.aws_url
    s3         = var.aws_url
    s3control  = var.aws_url
    sns        = var.aws_url
    sqs        = var.aws_url
    sts        = var.aws_url
  }
}
