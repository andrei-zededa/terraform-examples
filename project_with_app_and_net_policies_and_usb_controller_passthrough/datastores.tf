# If this already exists, we can either use a data block or import it. 
# terraform import zedcloud_datastore.Local_HTTP_Server_8080 0ebcfb8d-1bd7-46d3-8058-5b0194bf195b
resource "zedcloud_datastore" "Local_HTTP_Server_8080" {
  name  = "Local_HTTP_Server_8080"
  title = "Local_HTTP_Server_8080"

  ds_type = "DATASTORE_TYPE_HTTP"
  ds_fqdn = "http://192.168.192.168:8080"
  ds_path = "images_datastore"
}
