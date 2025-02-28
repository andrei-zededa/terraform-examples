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

  type = "TAG_TYPE_PROJECT"
  tag_level_settings {
    flow_log_transmission = "NETWORK_INSTANCE_FLOW_LOG_TRANSMISSION_UNSPECIFIED"
    # Zedcloud versions starting with 14.1.0 support `interface_ordering` and
    # if it is not specified then it will show up as a diff. Older versions do
    # NOT support it and if specified it will cause an error.
    interface_ordering = "INTERFACE_ORDERING_DISABLED"
  }
}
