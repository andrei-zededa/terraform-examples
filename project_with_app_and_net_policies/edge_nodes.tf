variable "onboarding_key" {
  description = "Zedcloud onboarding key"
  type        = string
  default     = "5d0767ee-0547-4569-b530-387e526f8cb9"
}

# NOTE: the difference between the resource and the name field.
resource "zedcloud_network" "edge_node_as_dhcp_client" {
  name  = "edge_node_as_dhcp_client_PROJ_${var.project_unique}"
  title = "edge_node_as_dhcp_client_PROJ_${var.project_unique}"
  kind  = "NETWORK_KIND_V4"

  project_id = zedcloud_project.PROJECT_1.id

  ip {
    dhcp = "NETWORK_DHCP_TYPE_CLIENT"
  }
  mtu = 1500
}

locals {
  # Filter and extract the value
  model_eth1_logical_label = [
    for obj in zedcloud_model.VM_WITH_MANY_PORTS.io_member_list :
    obj.logicallabel if obj.ztype == "IO_TYPE_ETH" && obj.phylabel == "eth1"
  ][0]
}

resource "zedcloud_edgenode" "EDGE_NODE_1" {
  name           = "EDGE_NODE_${var.project_unique}_FROM_TF"
  title          = "EDGE_NODE_${var.project_unique}_FROM_TF"
  serialno       = var.project_unique
  onboarding_key = var.onboarding_key
  model_id       = zedcloud_model.VM_WITH_MANY_PORTS.id
  project_id     = zedcloud_project.PROJECT_1.id
  # utype          = "AMD64"
  # The TF provider SHOULD know how to do 2 API requests if needed to set a
  # newly created edge node to ADMIN_STATE_ACTIVE.
  admin_state = "ADMIN_STATE_ACTIVE"

  interfaces {
    intfname = "first_physical_intf" # Must match the logical label defined in the model.
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
    # intfname   = "2nd_physical_intf" # Must match the logical label defined in the model.
    # Just as a POC on how to extract the logical label from the model, should be functionally
    # the same as `intfname   = "2nd_physical_intf"`.
    intfname   = local.model_eth1_logical_label
    intf_usage = "ADAPTER_USAGE_APP_SHARED"
    cost       = 0
    # netname    = zedcloud_network.edge_node_as_dhcp_client.name
    tags = {
      net_intf_second = "true"
    }
  }

  tags = {}
}

# This is used to move an edge-node to the *to be deleted* project before that
# edge-node is to be destroyed. It's used as a *pre-destroy hook* for that
# respective edge-node.
resource "null_resource" "edge_node_pre_destroy_hook" {
  triggers = {
    node = zedcloud_edgenode.EDGE_NODE_1.id
    proj = zedcloud_project.edge_nodes_to_be_deleted.id
  }

  provisioner "local-exec" {
    when = destroy
    command = "./scripts/move_edge_node_to_project.sh ${self.triggers.node} ${self.triggers.proj}" 
  }
}
