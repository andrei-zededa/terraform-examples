# This already exists, we can either use a data block or import it. 
# terraform import zedcloud_image.ubuntu_24_04_with_modbus_disk_999MB e5f9f886-03b6-43b1-b64e-e288702c24d7
resource "zedcloud_image" "ubuntu_24_04_with_modbus_disk_999MB" {
  name  = "ubuntu_24_04_with_modbus_disk_999MB"
  title = "ubuntu_24_04_with_modbus_disk_999MB"

  # This creates an implicit dependency on the `zedcloud_datastore.Local-HTTP-Server-8080` resource
  # so a block like:
  #     depends_on = [
  #       zedcloud_datastore.Local-HTTP-Server-8080
  #     ]
  # is not needed.
  datastore_id = zedcloud_datastore.Local-HTTP-Server-8080.id

  # The resulting URL for downloading the image will be:
  #     ${ds_fqdn}/${ds_path}/${image_rel_url}
  #     http://192.168.192.168:8080/images_datastore/ubuntu_24_04_with_modbus_disk_999MB.qcow2
  image_rel_url    = "ubuntu_24_04_with_modbus_disk_999MB.qcow2"
  image_format     = "QCOW2"
  image_arch       = "AMD64"
  image_sha256     = "CA1CD93D8863B08BA089559A11AE1F4C2B518B69B572FC629479F9052A747E19"
  image_size_bytes = 1018757120
  image_type       = "IMAGE_TYPE_APPLICATION"
}
