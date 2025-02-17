variable "edge_node_asus_nuc_serial" {
  type      = string
  sensitive = true
  default   = "S.........................."
}

resource "zedcloud_edgenode" "EDGE_NODE_ASUS_NUC" {
  name           = "GREYNUC01_X21537851_FROM_TF"
  title          = "GREYNUC01_X21537851_FROM_TF"
  serialno       = var.edge_node_asus_nuc_serial
  onboarding_key = var.onboarding_key
  model_id       = zedcloud_model.ASUS_NUC_14_PRO_PLUS.id
  project_id     = zedcloud_project.PROJECT_1.id
  # project_id = zedcloud_project.default.id
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
    intfname   = "USB3" # Must match *logical label* of IO member defined in the model.
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
    netname    = zedcloud_network.default_ipv4_dhcp_client.name
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
