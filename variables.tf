variable "project_name" {
  type    = string
  default = "my-cool-project-data"
}

variable "ingress_ports" {
  type = map(object({
    port     = string
    protocol = string
  }))
  default = {
    http  = { port = "80", protocol = "tcp" }
    https = { port = "443", protocol = "tcp" }
  }
}

variable "aws_url" {
  type    = string
  default = "http://localhost:4566"
}
