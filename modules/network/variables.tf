variable "subnet_cidr_block_newbits" {
  type = number
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
