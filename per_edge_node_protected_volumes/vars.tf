# We define the list of all edge-nodes as the `devices` array.
locals {
  devices_list = [
    {
      name          = "ENODE_200"
      serial_number = "SN10200"
    },
    {
      name          = "ENODE_201"
      serial_number = "SN10201"
    },
    {
      name          = "ENODE_202"
      serial_number = "SN10202"
    },
    {
      name          = "ENODE_203"
      serial_number = "SN10203"
    },
    {
      name          = "ENODE_204"
      serial_number = "SN10204"
    },
    # {
    #  name          = "ENODE_205"
    #  serial_number = "SN10205"
    # },
  ]

  allow_volume_destroy = {
    ENODE_200 = true
    ENODE_201 = true
    ENODE_202 = true
    ENODE_203 = true
    ENODE_204 = true
    ENODE_205 = true
  }

  # Convert the array to a map with unique keys for easier use with `for_each`.
  devices_map = {
    for index, device in local.devices_list :
    device.name => device
  }
}

# MUST use a moved block for each volume that we want to destroy.
# moved {
#   from = zedcloud_volume_instance.PROTECTED_PER_EDGE_NODE_VOLUMES_COLOR_RED[""]
#   to = zedcloud_volume_instance.DESTROYABLE_PER_EDGE_NODE_VOLUMES_COLOR_RED[""]
# }

# moved {
#    from = zedcloud_volume_instance.PROTECTED_PER_EDGE_NODE_VOLUMES_COLOR_RED["EDGE_NODE_AAAA"]
#    to = zedcloud_volume_instance.DESTROYABLE_PER_EDGE_NODE_VOLUMES_COLOR_RED["EDGE_NODE_AAAA"]
# }
#
moved {
   from = zedcloud_volume_instance.PROTECTED_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_200"]
   to = zedcloud_volume_instance.DESTROYABLE_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_200"]
}
moved {
   from = zedcloud_volume_instance.PROTECTED_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_201"]
   to = zedcloud_volume_instance.DESTROYABLE_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_201"]
}
moved {
   from = zedcloud_volume_instance.PROTECTED_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_202"]
   to = zedcloud_volume_instance.DESTROYABLE_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_202"]
}
moved {
   from = zedcloud_volume_instance.PROTECTED_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_203"]
   to = zedcloud_volume_instance.DESTROYABLE_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_203"]
}
moved {
   from = zedcloud_volume_instance.PROTECTED_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_204"]
   to = zedcloud_volume_instance.DESTROYABLE_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_204"]
}
moved {
   from = zedcloud_volume_instance.PROTECTED_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_205"]
   to = zedcloud_volume_instance.DESTROYABLE_PER_EDGE_NODE_VOLUMES_COLOR_RED["ENODE_205"]
}
