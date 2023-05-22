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

data "ipm_hub_module" "hub_module" {
  network_id = "fe1ec0a8-2dc7-402c-86d8-5ea0ebaa2ebe"
}

output "hub_module" {
  value = data.ipm_hub_module.hub_module
}


