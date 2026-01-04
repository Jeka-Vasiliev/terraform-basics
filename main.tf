resource "aws_s3_bucket" "project_bucket" {
  bucket = var.project_name
  tags = {
    Environment = var.environment
  }
}

resource "aws_security_group" "app-sg" {
  name = "app-sg"
  vpc_id = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_subnet" "public" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = cidrsubnet(data.aws_vpc.default.cidr_block, 4, 6)

  tags = {
    Name = "HelloWorld-Subnet"
  }
}
