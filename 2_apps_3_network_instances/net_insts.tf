resource "zedcloud_network_instance" "ni_local_nat_default" {
  name           = "ni_local_nat_default"
  title          = "ni_local_nat_default"
  kind           = "NETWORK_INSTANCE_KIND_LOCAL"
  type           = "NETWORK_INSTANCE_DHCP_TYPE_V4"
  port           = "uplink"
  device_default = true
  device_id      = zedcloud_edgenode.EDGE_NODE_1.id
  ip {
    dhcp_range {
      end   = "192.168.66.100"
      start = "192.168.66.199"
    }
    dns = [
      "9.9.9.9",
      "192.168.66.254"
    ]
    domain  = ""
    gateway = "192.168.66.254"
    ntp     = "13.13.13.13"
    subnet  = "192.168.66.0/24"
  }
  depends_on = [zedcloud_edgenode.EDGE_NODE_1]
}
