resource "zedcloud_volume_instance" "PROTECTED_PER_EDGE_NODE_VOLUMES_COLOR_RED" {
  # Create an instance of this resource for each edge-node.
  #   `for_each = zedcloud_edgenode.EDGE_NODES` - would not work due to unknown info before apply.
  # A simple
  #   `for_each = local.devices_map` - would work if we wouldn't need to check
  #   for the presence of the edge-node name in the `allow_volume_destroy` map.
  for_each = {
    for k, v in local.devices_map : k => v if !lookup(local.allow_volume_destroy, k, false)
  }

  name      = "${each.value.name}_RED_VOL"
  title     = "${each.value.name}_RED_VOL"
  device_id = zedcloud_edgenode.EDGE_NODES[each.key].id

  size_bytes = tostring(100 * 1024 * 1024) # 100MB
  # VOLUME_INSTANCE_TYPE_UNSPECIFIED
  # VOLUME_INSTANCE_TYPE_EMPTYDIR
  # VOLUME_INSTANCE_TYPE_BLOCKSTORAGE
  # VOLUME_INSTANCE_TYPE_HOSTFS
  # VOLUME_INSTANCE_TYPE_TMPFS
  # VOLUME_INSTANCE_TYPE_SECRET
  # VOLUME_INSTANCE_TYPE_NFS
  # VOLUME_INSTANCE_TYPE_AWS_BLOCK_STORAGE
  # VOLUME_INSTANCE_TYPE_CONTENT_TREE
  type        = "VOLUME_INSTANCE_TYPE_EMPTYDIR"
  accessmode  = "VOLUME_INSTANCE_ACCESS_MODE_READWRITE"
  multiattach = false
  cleartext   = true

  label = "volume_color_red"
  tags = {
    volume_color_red = "red"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "zedcloud_volume_instance" "DESTROYABLE_PER_EDGE_NODE_VOLUMES_COLOR_RED" {
  # Create an instance of this resource for each edge-node that is also present
  # in the `allow_volume_destroy` map and set to `true` there.
  for_each = {
    for k, v in local.devices_map : k => v if lookup(local.allow_volume_destroy, k, false)
  }

  name      = "${each.value.name}_RED_VOL"
  title     = "${each.value.name}_RED_VOL"
  device_id = zedcloud_edgenode.EDGE_NODES[each.key].id

  size_bytes = tostring(100 * 1024 * 1024) # 100MB
  # VOLUME_INSTANCE_TYPE_UNSPECIFIED
  # VOLUME_INSTANCE_TYPE_EMPTYDIR
  # VOLUME_INSTANCE_TYPE_BLOCKSTORAGE
  # VOLUME_INSTANCE_TYPE_HOSTFS
  # VOLUME_INSTANCE_TYPE_TMPFS
  # VOLUME_INSTANCE_TYPE_SECRET
  # VOLUME_INSTANCE_TYPE_NFS
  # VOLUME_INSTANCE_TYPE_AWS_BLOCK_STORAGE
  # VOLUME_INSTANCE_TYPE_CONTENT_TREE
  type        = "VOLUME_INSTANCE_TYPE_BLOCKSTORAGE"
  accessmode  = "VOLUME_INSTANCE_ACCESS_MODE_READWRITE"
  multiattach = false
  cleartext   = true

  label = "volume_color_red"
  tags = {
    volume_color_red = "red"
  }

  lifecycle {
    prevent_destroy = false
  }
}
