# edge_node_ssh_pub_key: If non-empty will trigger enabling SSH access to
# edge-nodes via `config_item` `debug.enable.ssh`."
#
# See: https://github.com/lf-edge/eve/blob/master/docs/CONFIG-PROPERTIES.md ,
# https://help.zededa.com/hc/en-us/articles/17918434708763-How-to-enable-and-disable-SSH-for-an-Edge-Device#h_01H9HCZX6K77DR2CVNC1AFJMYG .
#
# The corresponding `config_item` entry can be added both at the project level
# and per-edge-node. If both are set then the per-edge-node item will take
# precedence.
variable "edge_node_ssh_pub_key" {
  description = "Enable edge-node SSH access with the provided SSH public key" 
  sensitive = true
  type      = string
  default   = ""
}

# edge_node_serial_prefix: edge-node serial numbers must be unique across a
# Zedcloud cluster. If testing with virtual edge-nodes it's possible to run
# into a situation in which onboarding to a specific enterprise fails due to
# the same serial-number being used by a virtual edge-node in another
# enterprise. This prefix can be used to generate unique serial-numbers
# more easily.
variable "edge_node_serial_prefix" {
  type    = string
  default = ""
}

# We define the list of all edge-nodes as the `devices` array.
locals {
  devices_list = [
    {
      name          = "ENODE_430"
      serial_number = "${var.edge_node_serial_prefix}SN_AB_430"
      model_id      = zedcloud_model.VM_WITH_MANY_PORTS.id
    },
    {
      name          = "ENODE_431"
      serial_number = "${var.edge_node_serial_prefix}SN_AB_431"
      model_id      = zedcloud_model.VM_WITH_MANY_PORTS.id
    },
    {
      name          = "ENODE_439"
      serial_number = "${var.edge_node_serial_prefix}SN_AB_439"
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
