locals {
  env_settings = {
    default = {
        bucket_force_destroy = false
    }
    dev = {
        bucket_force_destroy = true
    }
  }

  current_env = lookup(local.env_settings, terraform.workspace, local.env_settings["default"])
}
