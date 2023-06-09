terraform {
  required_providers {
    ipm = {
      source = "infinera.com/poc/ipm"
    }
  }
}

provider "ipm" {
  username = var.ipm_user
  password = var.ipm_password
  host     = var.ipm_host
}

module "networks" {
  source   = "git::https://github.com/infinera/terraform-ipm_modules.git//network-service/workflows/networks"

  networks = var.networks
  system_data_path = var.system_data_path
  user_data_path   = var.user_data_path
}

output "networks" {
  value = module.networks
}

