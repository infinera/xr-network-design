# Constellation Network 
The user can create one or more constellation networks by specify the desired intent for the networks and their modules.
Basically for any network configurations, There are two required data : the intent and the configuration profiles.
* The configuration Intent are specified by user to create, retrieve, update and delete the network.
* The configuration Profiles are defined once and they include both system defined and user define configuration settings. Please refer to the [Detail Readme](https://github.com/infinera/terraform-ipm_modules/blob/master/network-mgnmt/Intent%20and%20Profiles.md) for more information.

## Prerequisite
1. The "infinera.com/poc/ipm" provider is accessible from infinera repository
2. Terraform (Install terraform via https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. IPM server credentials: Define the following environment variables: TF_VAR_ipm_user, TF_VAR_ipm_password, and TF_VAR_ipm_host. 
4. If it is required, the user defined Constellation Network profiles.json must be available in the TF root directory (where the command "terraform apply" is executed)
5. Create new **ABC** directory go to existing **ABC** directory. Copy files *variables.tf*, *main.tf*, *profiles.json* and input file *network.tfvars* to directory **ABC**. Please refer to the [Detail Readme](https://github.com/infinera/terraform-ipm_modules/blob/master/network-mgnmt/Intent%20and%20Profiles.md) for more information. 
<pre>
    Directory ABC -----|-----> network.tfvars  // Update the intent for CRUD operations. Please see variables.tf for the intent definition.
                       |
                       |-----> main.tf         // TF executable file. Normally no change is required unless user wants to specify custom output. 
                       |                          Require Terraform HCL knowledge.
                       |
                       |-----> variables.tf    // Fixed. Defined the intent definition. Do not change.
                       |
                       |-----> <b>profiles.json</b>   // Globally, Site or Region User defined profiles for pre-defined configuration settings.
                                               // This can be placed in this directory (TF_ROOT) or a designated directory via TF_VAR_profile_directory
                                               // environment variable.
</pre>

## Create Constellation Network With No Leaf 
### __Steps__
1. Update intent file *network.tfvars* as needed
2. Execute command *terraform init*. The TF *init* command is needed to execute initially once only or whenever the user wants to start Terraform session at clean state.
3. Then Execute command *terraform apply -var-file=network.tfvars*

### __Intent File__ ( *network.tfvars* )
```
networks = [{name= "XR Network1", 
             profile = "network_profile1",  
             hub_module = { identifier = {name = "PORT_MODE_HUB"}}}]
```
### __Result__: "XR Network1" Network is created with Hub module *PORT_MODE_HUB*
```
Network ( Name = XR Network1,  ---------|----------> No Leaf
          hub = PORT_MODE_HUB )         |
```
## Create Constellation Network With One Leaf
### __Steps__
1. Update intent file *network.tfvars* to add the leaf module *"PORT_MODE-LEAF1"*
2. Execute command *terraform apply -var-file=network.tfvars*

### __Intent File__ ( *network.tfvars* )
<pre>
networks = [{name= "XR Network1", 
             profile = "network_profile1",  
             hub_module = { identifier = {name = "PORT_MODE_HUB"} },
             <b>leaf_modules = [{ identifier = {name = "PORT_MODE-LEAF1"}}]</b>
            }]
</pre>

### __Result__: New Leaf "PORT_MODE_LEAF1" is added to "XR Network1" XR Network
```
Network (Name = *XR Network1*, hub =* PORT_MODE_HUB* )-------------|-----> leaf 1 = PORT_MODE_LEAF1

```
## Add New Leaf Modules to Constellation Network
### __Steps__
1. Update intent file *network.tfvars* to add two more leaf modules: *PORT_MODE_LEAF2* and *PORT_MODE_LEAF3*
2. Execute command *terraform apply -var-file=network.tfvars*

### __Intent File__ ( *network.tfvars* )
<pre>
networks = [{name= "XR Network1", 
             profile = "network_profile1",  
             hub_module = { identifier = {name = "PORT_MODE_HUB"} },
             leaf_modules=[{identifier =  {name = "PORT_MODE_LEAF1"}},
                            <b>{identifier =  {name = "PORT_MODE_LEAF2"}}</b>,
                            <b>{identifier = {name = "PORT_MODE_LEAF3"}}</b>],
            }]
</pre>

### __Result__: New Leaf "PORT_MODE_LEAF1" is added to "XR Network1" XR Network
```
Network ( Name = XR Network1,  -------------|----------> leaf 1 = PORT_MODE_LEAF1
          hub = PORT_MODE_HUB )             |
                                            |----------> leaf 2 = PORT_MODE_LEAF2
                                            |
                                            |----------> leaf 3 = PORT_MODE_LEAF3
```

## Remove Leaf Modules From The Created XR Network
### __Steps__
1. Update intent file *network.tfvars* to remove two leaf modules: *PORT_MODE_LEAF1* and *PORT_MODE_LEAF3*
2. Execute command *terraform apply -var-file=network.tfvars*

### __Intent File__ ( *network.tfvars* )
<pre>
networks = [{name= "XR Network1", 
             profile = "network_profile1",  
             hub_module = { identifier = {name = "PORT_MODE_HUB"} },
             leaf_modules=[<s>{identifier =  {name = "PORT_MODE_LEAF2"}},</s>
                            {identifier =  {name = "PORT_MODE_LEAF2"}},
                            <s>{identifier = {name = "PORT_MODE_LEAF3"}}</s>]
            }]
</pre>

### __Result__: Two Leaf Modules "PORT_MODE_LEAF1" and "PORT_MODE_LEAF3" are removed from "XR Network1" XR Network
```
Network ( Name = XR Network1,  -------------|----------> leaf 1 = PORT_MODE_LEAF2
          hub = PORT_MODE_HUB )             |
```

## Update The Configuration Settings For the XR Network and all its Modules
### __Steps__
1. Update intent file *network.tfvars* to specify configuration profile *network_profile2* for network *XR Network1*. 
2. Execute command *terraform apply -var-file=network.tfvars*

### __Intent File__ ( *network.tfvars* )
<pre>
  networks = [{name= "XR Network1", 
                profile = <b>"network_profile2"</b>, 
                hub_module = { identifier = {name = "PORT_MODE_HUB"}}, 
                leaf_modules=[{identifier =  {name = "PORT_MODE_LEAF2"}}]}]
</pre>
### __Result__: The network, its hub, its leaf modules's configurations are updated using the network profile "network_profile2"
The *network_profile2* profile specifies the configuration profiles for the network, its hub module and its leaf modules.

## Update The Configuration Settings for the XR Network Only
### __Steps__
1. Update intent file *network.tfvars* to specify configuration settings for network *XR Network1*. 
2. Execute command *terraform apply -var-file=network.tfvars*

### __Intent File__ ( *network.tfvars* )
<pre>
  networks = [{name= "XR Network1", 
                profile = "network_profile2", 
               <b>constellation_frequency= 193000, modulation = "16QAM", managed_by="cm", tc_mode=true</b>,
                hub_module = { identifier = {name = "PORT_MODE_HUB"}}, 
                leaf_modules=[{identifier =  {name = "PORT_MODE_LEAF2"}}]}]
</pre>
### __Result__: The network "Network1" configuration shall be updated with the specified attribute/value settings.

## Update The Configuration Settings for the Hub Module of an XR Network
### __Steps__
1. Update intent file *network.tfvars* to specify configuration settings for the hub module *PORT_MODE_HUB*. 
2. Execute command *terraform apply -var-file=network.tfvars*

### __Intent File__ ( *network.tfvars* )le
<pre>
  networks = [{name= "XR Network1", 
                profile = "network_profile2", 
                hub_module = { identifier = {name = "PORT_MODE_HUB"},
                               <b>traffic_mode: "L1Mode",fiber_connection_mode: "single"", managed_by: "cm"", planned_capacity: "400G",
                                requested_nominal_psd_offset: "+3dB", fec_iterations: "standard", tx_clp_target: -3500</b>}, 
                leaf_modules=[{identifier =  {name = "PORT_MODE_LEAF2"}}]}]
</pre>
### __Result__: The hub module's configuration of the network "Network1" shall be updated with the specified configurations.

## Update The Configuration Settings for the Leaf Modules of an XR Network
### __Steps__
1. Update intent file *network.tfvars* to specify configuration settings for the leaf module *PORT_MODE_LEAF1* and *PORT_MODE_LEAF2*.
   a. The leaf module *PORT_MODE_LEAF1* shall use the config_profile *leaf_profile2* specifications.
   b. The leaf module *PORT_MODE_LEAF2* shall use the inline attributes' specifications.
2. Execute command *terraform apply -var-file=network.tfvars*

### __Intent File__ ( *network.tfvars* )
<pre>
  networks = [{name= "XR Network1", 
                profile = "network_profile2", 
                hub_module = { identifier = {name = "PORT_MODE_HUB"}}, 
                leaf_modules=[{identifier =  {name = "PORT_MODE_LEAF1"},
                               <b>config_profile = "leaf_profile2"</b>},
                               {identifier =  {name = "PORT_MODE_LEAF2"}, 
                               <b>traffic_mode: "L1Mode",fiber_connection_mode: "single"", managed_by: "cm"", planned_capacity: "400G",
                                requested_nominal_psd_offset: "+3dB", fec_iterations: "standard", tx_clp_target: -3500</b>}]}]
</pre>
### __Result__: The leaf modules' configurations of the network "Network1" shall be updated with the specified attribute/value settings.
  * The leaf module "PORT_MODE_LEAF1" configuration shall be updated using the **network_profile2** profile specifications.
  * The leaf module "PORT_MODE_LEAF2" configuration shall be updated using the specified inline attributes' configurations.

## Delete The XR Network
### __Steps__
1. Update intent file *network.tfvars* to remove the network *"XR Network1*
2. Execute command *terraform apply -var-file=network.tfvars*

### __Intent File__ ( *network.tfvars* )
<pre>
  networks = [<s>{name= "XR Network1", 
                profile = "network_profile2", 
                hub_module = { identifier = {name = "PORT_MODE_HUB"}}, 
                leaf_modules=[{identifier =  {name = "PORT_MODE_LEAF1"}, 
                               config_profile = "leaf_profile2"},
                               {identifier =  {name = "PORT_MODE_LEAF2"}, 
                               traffic_mode: "L1Mode",fiber_connection_mode: "single"", managed_by: "cm"", planned_capacity: "400G",
                                requested_nominal_psd_offset: "+3dB", fec_iterations: "standard", tx_clp_target: -3500}]}</s>]
</pre>
### __Result__: The network "Network1" shall be deleted.

## Example of TF main.tf
```
terraform {
  required_providers {
    ipm = {
      source = "infinera.com/poc/ipm"
    }
  }
}

provider "ipm" {
  username = var.ipm_user     // TF_VAR_ipm_user
  password = var.ipm_password // TF_VAR_ipm_password
  host     = var.ipm_host     // TF_VAR_ipm_host
}

module "network" {
  source                   = "git::https://github.com/infinera/terraform-ipm_modules.git//common/workflows/network"
  <b>networks</b>                 = var.networks 
}
```
## Intent Definitions, Profile Definitions and Their Usages
**Please see [Detail Readme](https://github.com/infinera/terraform-ipm_modules/blob/master/network-mgnmt/Intent%20and%20Profiles.md) for more information about the intent definition and profile settings and usages.**
