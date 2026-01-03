resource "aws_s3_bucket" "project_bucket" {
  bucket = var.project_name
  tags = {
    Environment = var.environment
  }
}

resource "aws_security_group" "app-sg" {
  name = "app-sg"

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
