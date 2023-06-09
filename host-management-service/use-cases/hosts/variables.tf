variable "hosts" {
  type = list(object({ 
                      profile = optional(string),
                      name = optional(string), 
                      managed_by = optional(string), 
                      location = optional(object({longtitude = number, latitude = number})),
                      labels = optional(map(string)),
                      identifier = object({name = optional(string), id = optional(string), serial_number = optional(string), 
                                           mac_address = optional(string), host_chassis_id = optional(string), host_chassis_id_subtype = optional(string)}),
         }))
  description = "List of Host"
  default = [{ name = "Host1", profile = "system_host_profile1",
               identifier = {host_chassis_id = "192.168.101.1", host_chassis_id_subtype = "ipAddress"} }]
}

variable "host_profiles" {
  type = map(object({ managed_by = optional(string), location = optional(object({longtitude = number, latitude = number})),
                      labels = optional(map(string)),}))
  description = "Map of Host profiles"
}

variable "system_data_path" {
  type = string
}

variable "user_data_path" {
  type = string
}


