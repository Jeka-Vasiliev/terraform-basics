terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"

    endpoints = {
      s3 = "http://localhost:4566"
    }
    use_path_style              = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = var.project_name
  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "logs_bucket" {
  bucket = "${var.project_name}-logs"
  depends_on = [
    aws_s3_bucket.project_bucket
  ]
}

module "network_dev" {
  source            = "./modules/network"
  env               = "development"
  subnet_cidr_block = 6
  ingress_ports     = var.ingress_ports
}
