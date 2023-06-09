variable "network_connections" {
  type = list(object({ profile = optional(string),
                      name = optional(string), service_mode = optional(string), mc = optional(string),
                      outer_vid = optional(string), implicit_transport_capacity = optional(string), labels = optional(map(string)),
                      endpoints = list(object({ identifier = object({module_name = optional(string), module_id = optional(string), serial_number = optional(string), 
                                                                mac_address = optional(string), host_port_name = optional(string), host_name = optional(string),
                                                                host_chassis_id = optional(string), host_chassis_id_subtype = optional(string),
                                                                host_port_id = optional(string), host_port_id_subtype = optional(string),
                                                                host_sys_name  = optional(string), host_port_source_mac = optional(string)}),
                                                capacity = optional(number)}))
  }))
  description = "List of Network Connection"
}