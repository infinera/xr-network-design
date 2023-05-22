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

data "ipm_host_ports" "host_ports" {
  host_id = "a9374475-c09a-4285-b281-1541da386dca"
}

output "host_ports" {
  value = data.ipm_host_ports.host_ports
}


