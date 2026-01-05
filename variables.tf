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

variable "bucket_force_destroy" {
  type    = bool
  description = "If true, the S3 bucket will be forcefully destroyed along with all its contents when the infrastructure is destroyed."
}
