variable "subnet_cidr_block" {
  type = string
}

variable "env" {
  type = string
}

variable "ingress_ports" {
  type = map(object({
    port     = string
    protocol = string
  }))
}
