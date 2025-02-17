# default_ipv4_dhcp_client: This is an *enterprise default* network object which
# configures an edge-node physical interface for the most common situation:
# *IPv4 DHCP client*. This network object is created as part of the `default`
# project but it can be used by any edge-node in any project of the same
# enterprise.
resource "zedcloud_network" "default_ipv4_dhcp_client" {
  name  = "default_ipv4_dhcp_client"
  title = "default_ipv4_dhcp_client"
  kind  = "NETWORK_KIND_V4"

  project_id         = zedcloud_project.default.id
  enterprise_default = true

  ip {
    dhcp = "NETWORK_DHCP_TYPE_CLIENT"
  }
  mtu = 1500
}
