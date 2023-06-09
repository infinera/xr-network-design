variable "network_connections" {
  type = list(object({ profile = optional(string),
    name      = optional(string), service_mode = optional(string), mc = optional(string),
    outer_vid = optional(string), implicit_transport_capacity = optional(string), labels = optional(map(string)),
    endpoints = list(object({ identifier = object({ module_name = optional(string), module_id = optional(string), serial_number = optional(string),
      mac_address     = optional(string), host_port_name = optional(string), host_name = optional(string),
      host_chassis_id = optional(string), host_chassis_id_subtype = optional(string),
      host_port_id    = optional(string), host_port_id_subtype = optional(string),
      host_sys_name = optional(string), host_port_source_mac = optional(string) }),
    capacity = optional(number) }))
  }))
  description = "List of Network Connection"
  default = [{ profile = "nc_profile1",
    endpoints = [{ identifier = { host_chassis_id = "192.168.101.1", host_chassis_id_subtype = "ipAddress", host_port_id = "192.168.101.1",
      host_port_id_subtype = "ipAddress" } }, { identifier = { host_chassis_id = "cb3b.783c.38db", host_chassis_id_subtype = "chassisComponent",
    host_port_id = "bc3b.783c.38bd", host_port_id_subtype = "portComponent" }, capacity = 400 }]
  }]
}

variable "nc_profiles" {
  type = map(object({ service_mode = optional(string), mc = optional(string), outer_vid = optional(string),
  implicit_transport_capacity = optional(string), labels = optional(map(string)), endpoint_capacity : optional(string) }))
  description = "Map of NC Config profiles"
}

variable "system_data_path" {
  type    = string
  default = "../../ipm-data"
}

variable "user_data_path" {
  type    = string
  default = "../../ipm-data"
}


