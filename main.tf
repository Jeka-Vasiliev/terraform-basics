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
  source      = "./modules/network"
  env = "development"
  subnet_cidr_block = 6
  ingress_ports = var.ingress_ports
}
