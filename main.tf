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
  bucket        = "${terraform.workspace}-${var.project_name}"
  force_destroy = local.current_env.bucket_force_destroy

  tags = {
    Environment = terraform.workspace
  }
}

resource "aws_s3_bucket" "logs_bucket" {
  bucket        = "${terraform.workspace}-${var.project_name}-logs"
  force_destroy = local.current_env.bucket_force_destroy

  depends_on = [
    aws_s3_bucket.project_bucket
  ]
}

module "network_dev" {
  source                    = "./modules/network"
  env                       = "development"
  subnet_cidr_block_newbits = 4
  ingress_ports             = var.ingress_ports
}
