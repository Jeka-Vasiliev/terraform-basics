locals {
  env_settings = {
    default = {
      bucket_force_destroy = false
      ingress_ports        = [80]
    }
    dev = {
      bucket_force_destroy = true
      ingress_ports        = [80, 443]
    }
  }

  current_env = lookup(local.env_settings, terraform.workspace, local.env_settings["default"])
}
