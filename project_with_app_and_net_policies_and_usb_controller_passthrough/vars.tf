# We define the list of all edge-nodes as the `devices` array.
locals {
  devices_list = [
    {
      name          = "ENODE_430"
      serial_number = "SN_AB_430"
      model_id      = zedcloud_model.VM_WITH_MANY_PORTS.id
    },
    {
      name          = "ENODE_431"
      serial_number = "SN_AB_431"
      model_id      = zedcloud_model.VM_WITH_MANY_PORTS.id
    },
    {
      name          = "ENODE_439"
      serial_number = "SN_AB_439"
      model_id      = zedcloud_model.VM_WITH_MANY_PORTS_AND_USB.id
    },
    #     {
    #       name          = "ENODE_303"
    #       serial_number = "SN10303"
    #     },
    #     {
    #       name          = "ENODE_304"
    #       serial_number = "SN10304"
    #     },
    #     {
    #       name          = "ENODE_305"
    #       serial_number = "SN10305"
    #     },
    #     {
    #       name          = "ENODE_306"
    #       serial_number = "SN10306"
    #     },
    #     {
    #       name          = "ENODE_307"
    #       serial_number = "SN10307"
    #     },
    #     {
    #       name          = "ENODE_308"
    #       serial_number = "SN10308"
    #     },
    #     {
    #       name          = "ENODE_309"
    #       serial_number = "SN10309"
    #     },
  ]

  # Convert the array to a map with unique keys for easier use with `for_each`.
  devices_map = {
    for index, device in local.devices_list :
    device.name => device
  }
}

variable "edge_node_ssh_pub_key" {
  description = "If non-empty will trigger enabling SSH access to an edge-node via `config_item` `debug.enable.ssh`."
  sensitive   = true
  type        = string
  default     = ""
}
