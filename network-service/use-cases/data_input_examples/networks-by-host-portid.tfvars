networks = [{ name = "XR Network1",
               network_profile = "network_profile1",
               hub_module      = { identifier = {host_chassis_id = "00:00:00:00:00:01", host_chassis_id_subtype = "macAddress", host_port_id = "00:00:00:00:00:01",
                                   host_port_id_subtype = "macAddress"}, 
                                   config = { traffic_mode = "VTIMode" } },
              leaf_modules = [{ identifier = {host_chassis_id = "192.168.101.1", host_chassis_id_subtype = "networkAddress", host_port_id = "192.168.101.1", 
                                host_port_id_subtype = "networkAddress"}}, { identifier = {host_chassis_id = "cb3b.783c.38db",
                                host_chassis_id_subtype = "chassisComponent",
                                host_port_id = "bc3b.783c.38bd", host_port_id_subtype = "portComponent"}, config = { traffic_mode : "VTIMode" } }] 
             }]