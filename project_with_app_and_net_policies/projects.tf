variable "project_unique" {
  description = "The unique part of the project name and or other related resource names"
  type        = string
  default     = "AAAABBBB1234CI571" # Also used as the edge node serial number.
}

variable "project_name" {
  description = "The project name"
  type        = string
  default     = "PROJ_AAAABBBB1234CI571_FROM_TF"
}

resource "zedcloud_project" "PROJECT_1" {
  name  = var.project_name
  title = "Project ${var.project_unique} created via terraform"

  depends_on = [
    zedcloud_application.ubuntu_3nic_test_aaaa,
    zedcloud_application.ubuntu_3nic_test_bbbb
  ]

  type = "TAG_TYPE_PROJECT"
  tag_level_settings {
    flow_log_transmission = "NETWORK_INSTANCE_FLOW_LOG_TRANSMISSION_UNSPECIFIED"
    # Zedcloud versions starting with 14.1.0 support `interface_ordering` and
    # if it is not specified then it will show up as a diff. Older versions do
    # NOT support it and if specified it will cause an error.
    interface_ordering = "INTERFACE_ORDERING_DISABLED"
  }

  app_policy {
    # The name MUST be in the "$PROJECT_NAME.apppolicy" format.
    name  = "${var.project_name}.apppolicy"
    title = ""
    type  = "POLICY_TYPE_APP"

    app_policy {
      apps {
        name              = zedcloud_application.ubuntu_3nic_test_aaaa.name
        title             = ""
        app_id            = zedcloud_application.ubuntu_3nic_test_aaaa.id
        naming_scheme     = "APP_NAMING_SCHEME_PROJECT_APP_DEVICE"
        name_project_part = var.project_name
        name_app_part     = zedcloud_application.ubuntu_3nic_test_aaaa.name

        origin_type = "ORIGIN_UNSPECIFIED"

        cpus     = 0
        memory   = 0
        networks = 0

        manifest_json {
          ac_kind         = ""
          ac_version      = ""
          name            = ""
          app_type        = "APP_TYPE_VM"
          deployment_type = "DEPLOYMENT_TYPE_STAND_ALONE"
        }

        interfaces {
          intfname    = "1st_conn_port_fwd"
          intforder   = 1
          privateip   = false
          netinstname = ""
          netinsttag = {
            ni_local_nat = "true"
          }
        }

        interfaces {
          intfname    = "2nd_conn"
          intforder   = 2
          privateip   = false
          netinstname = ""
          netinsttag = {
            ni_local_switch = "true"
          }
        }

        interfaces {
          intfname    = "3rd_conn"
          intforder   = 3
          privateip   = false
          netinstname = ""
          netinsttag = {
            network = "ni_internal"
          }
        }

        start_delay_in_seconds = 10
      }

      apps {
        name              = zedcloud_application.ubuntu_3nic_test_bbbb.name
        title             = ""
        app_id            = zedcloud_application.ubuntu_3nic_test_bbbb.id
        naming_scheme     = "APP_NAMING_SCHEME_PROJECT_APP_DEVICE"
        name_project_part = var.project_name
        name_app_part     = zedcloud_application.ubuntu_3nic_test_bbbb.name

        origin_type = "ORIGIN_UNSPECIFIED"

        cpus     = 0
        memory   = 0
        networks = 0

        manifest_json {
          ac_kind         = ""
          ac_version      = ""
          name            = ""
          app_type        = "APP_TYPE_VM"
          deployment_type = "DEPLOYMENT_TYPE_STAND_ALONE"
        }

        interfaces {
          intfname    = "app_eth0"
          intforder   = 1
          privateip   = false
          netinstname = ""
          netinsttag = {
            ni_local_nat = "true"
          }
        }

        interfaces {
          intfname    = "app_eth1"
          intforder   = 2
          privateip   = false
          netinstname = ""
          netinsttag = {
            ni_local_switch = "true"
          }
        }

        interfaces {
          intfname    = "app_eth2"
          intforder   = 3
          privateip   = false
          netinstname = ""
          netinsttag = {
            network = "ni_internal"
          }
        }

        start_delay_in_seconds = 45
      }
    }
  }

  network_policy {
    # The name MUST be in the "$PROJECT_NAME.networkPolicy" format. Very consistent with the app policy naming !
    name  = "${var.project_name}.networkPolicy"
    title = ""
    type  = "POLICY_TYPE_NETWORK"

    network_policy {
      net_instance_config {
        name      = "ni_local_nat"
        title     = "ni_local_nat"
        kind      = "NETWORK_INSTANCE_KIND_LOCAL"
        type      = "NETWORK_INSTANCE_DHCP_TYPE_V4"
        device_id = "" # NOTE: Field is marked as mandatory in the TF provider.

        # port           = "uplink" # Most common configuration.
        port           = "first_physical_intf" # Must match the edge-node interface name which is set the same as the "logical label" in the model.
        device_default = true

        tags = {
          ni_local_nat = "true"
        }
      }

      net_instance_config {
        name      = "ni_local_switch"
        title     = "ni_local_switch"
        kind      = "NETWORK_INSTANCE_KIND_SWITCH"
        type      = "NETWORK_INSTANCE_DHCP_TYPE_UNSPECIFIED"
        device_id = "" # NOTE: Field is marked as mandatory in the TF provider.

        port           = "2nd_physical_intf" # Must match the edge-node interface name which is set the same as the "logical label" in the model.
        device_default = false

        tags = {
          ni_local_switch = "true"
        }
      }

      net_instance_config {
        name      = "ni_internal"
        title     = "ni_internal"
        kind      = "NETWORK_INSTANCE_KIND_LOCAL"
        type      = "NETWORK_INSTANCE_DHCP_TYPE_V4"
        device_id = "" # NOTE: Field is marked as mandatory in the TF provider.

        ip {
          subnet  = "192.168.13.0/24"
          gateway = "192.168.13.1"
          dns = [
            "192.168.13.1"
          ]
          dhcp_range {
            start = "192.168.13.128"
            end   = "192.168.13.254"
          }
        }

        tags = {
          network = "ni_internal"
        }
      }
    }
  }
}

# An edge-node that has app-instances and/or network-instances deployed to it
# cannot be deleted without first deleting those. However if those where deployed
# automatically as a result of the parent project's app/network policies then
# terraform is not aware of them to be able to destroy them. Therefore we create
# this empty project and before wanting to destroy an edge-node we first move
# it to this project so the app/network-instances are deleted automatically by
# Zedcloud.
resource "zedcloud_project" "edge_nodes_to_be_deleted" {
  name        = "edge_nodes_to_be_deleted_${var.project_unique}_FROM_TF"
  title       = "edge_nodes_to_be_deleted_${var.project_unique}_FROM_TF"
  description = <<-EOS
  Project ${var.project_unique} for edge nodes that need to be
   moved before deletion to a project without app/network policies.
  EOS

  type = "TAG_TYPE_PROJECT"
  tag_level_settings {
    flow_log_transmission = "NETWORK_INSTANCE_FLOW_LOG_TRANSMISSION_UNSPECIFIED"
    interface_ordering    = "INTERFACE_ORDERING_DISABLED"
  }
}
