# This already exists, we can either use a data block or import it. 
# terraform import zedcloud_image.ubuntu_24_04_with_modbus_disk_999MB 9c02df13-73b6-4abb-b543-246bcb161420
resource "zedcloud_image" "ubuntu_24_04_with_modbus_disk_999MB" {
  name  = "ubuntu_24_04_with_modbus_disk_999MB"
  title = "ubuntu_24_04_with_modbus_disk_999MB"

  depends_on = [
    zedcloud_datastore.Private_HTTP_Server_on_8080
  ]

  datastore_id = zedcloud_datastore.Private_HTTP_Server_on_8080.id

  image_rel_url    = "ubuntu_24_04_with_modbus_disk_999MB.qcow2"
  image_format     = "QCOW2"
  image_arch       = "AMD64"
  image_sha256     = "CA1CD93D8863B08BA089559A11AE1F4C2B518B69B572FC629479F9052A747E19"
  image_size_bytes = 1018757120
  image_type       = "IMAGE_TYPE_APPLICATION"
}
