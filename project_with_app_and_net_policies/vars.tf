# We define the list of all edge-nodes as the `devices` array.
locals {
  devices_list = [
    {
      name          = "ENODE_300"
      serial_number = "SN10300"
    },
    {
      name          = "ENODE_301"
      serial_number = "SN10301"
    },
    #     {
    #       name          = "ENODE_302"
    #       serial_number = "SN10302"
    #     },
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
