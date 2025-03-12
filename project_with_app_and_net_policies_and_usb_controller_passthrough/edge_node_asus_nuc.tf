resource "zedcloud_edgenode" "EDGE_NODE_ASUS_NUC" {
  name           = "GREYNUC01_X21537851_FROM_TF"
  title          = "GREYNUC01_X21537851_FROM_TF"
  serialno       = "S.........................."
  onboarding_key = var.onboarding_key
  model_id       = zedcloud_model.ASUS_NUC_14_PRO_PLUS.id
  project_id     = zedcloud_project.PROJECT_1.id
  # project_id = zedcloud_project.edge_nodes_to_be_deleted.id
  # utype          = "AMD64"
  # The TF provider knows how to do 2 API requests if needed to set a
  # newly created edge node to ADMIN_STATE_ACTIVE.
  admin_state = "ADMIN_STATE_ACTIVE"

  dynamic "config_item" {
    for_each = length(var.edge_node_ssh_pub_key) > 0 ? [1] : []
    content {
      key          = "debug.enable.ssh"
      string_value = var.edge_node_ssh_pub_key
      # Need to set this otherwise we keep getting diff with the info in Zedcloud.
      uint64_value = "0"
    }
  }

  interfaces {
    intf_usage = "ADAPTER_USAGE_APP_DIRECT"
    intfname   = "USB"
    cost       = 0
    tags = {
      "bundle" = "group9"
    }
  }

  interfaces {
    intf_usage = "ADAPTER_USAGE_APP_DIRECT"
    intfname   = "USB1"
    cost       = 0
    tags = {
      "bundle" = "group9"
    }
  }

  interfaces {
    intf_usage = "ADAPTER_USAGE_APP_DIRECT"
    intfname   = "USB2"
    cost       = 0
    tags = {
      "bundle" = "group9"
    }
  }

  interfaces {
    intf_usage = "ADAPTER_USAGE_APP_DIRECT"
    intfname   = "USB3"
    cost       = 0
    tags = {
      "bundle" = "group11"
    }
  }

  interfaces {
    intfname = "eth0" # Must match the logical label defined in the model.
    # AdapterUsage Adapter Usage
    #
    # - ADAPTER_USAGE_UNSPECIFIED: Adapter unspecified
    #   - ADAPTER_USAGE_MANAGEMENT: Adapter can be used by EVE as well as other Edge applications
    #   - ADAPTER_USAGE_APP_DIRECT: Adapter is directly used by one edge application
    #   - ADAPTER_USAGE_APP_SHARED: Adapter can be shared by different network instances
    #   - ADAPTER_USAGE_DISABLED: Adapter disabled, for future use
    intf_usage = "ADAPTER_USAGE_MANAGEMENT"
    cost       = 0
    netname    = zedcloud_network.edge_node_as_dhcp_client.name
    tags = {
      # Any string key/value pair should work here.
      net_intf_first = "true"
    }
  }

  interfaces {
    intf_usage = "ADAPTER_USAGE_APP_DIRECT"
    intfname   = "USB-8087:0033-3:10"
    cost       = 0
    tags = {
      "usb_device" = "unknown"
    }
  }

  interfaces {
    intf_usage = "ADAPTER_USAGE_APP_DIRECT"
    intfname   = "USB-STICK-FRONT-RIGHT"
    cost       = 0
    tags = {
      "front_panel" = "usb_a_port_to_the_right"
    }
  }

  tags = {}
}

#resource "zedcloud_network_instance" "nuc_ni_local_nat" {
#  name      = "greynuc_ni_local_nat"
#  title     = "greynuc_ni_local_nat"
#  kind      = "NETWORK_INSTANCE_KIND_LOCAL"
#  type      = "NETWORK_INSTANCE_DHCP_TYPE_V4"
#  device_id = zedcloud_edgenode.EDGE_NODE_ASUS_NUC.id
#
#  port           = "eth0"
#  device_default = false 
#
#  tags = {
#    ni_local_nat = "true"
#  }
#}
#
#resource "zedcloud_network_instance" "nuc_ni_local_switch" {
#  name      = "greynuc_local_switch"
#  title     = "greynuc_local_switch"
#  kind      = "NETWORK_INSTANCE_KIND_SWITCH"
#  type      = "NETWORK_INSTANCE_DHCP_TYPE_UNSPECIFIED"
#  device_id = zedcloud_edgenode.EDGE_NODE_ASUS_NUC.id
#
#  port           = ""
#  device_default = false
#
#  tags = {
#    ni_local_switch = "true"
#  }
#}
#
#resource "zedcloud_network_instance" "nuc_ni_internal" {
#  name      = "greynuc_ni_internal"
#  title     = "greynuc_ni_internal"
#  kind      = "NETWORK_INSTANCE_KIND_LOCAL"
#  type      = "NETWORK_INSTANCE_DHCP_TYPE_V4"
#  device_id = zedcloud_edgenode.EDGE_NODE_ASUS_NUC.id
#
#  port           = ""
#  device_default = false
#
#  tags = {
#    network = "ni_internal"
#  }
#}
