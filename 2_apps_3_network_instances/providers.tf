terraform {
  required_providers {
    # A locally built version of the Zedcloud TF provider needs to be copied as
    # the $HOME/.terraform.d/plugins/localhost/zededa/zedcloud/$VERSION/linux_amd64/terraform-provider-zedcloud
    # file (make user it's executable).
    #
    # NOTE: `$VERSION` does NOT start with `v`.
    zedcloud = {
      # source = "localhost/zededa/zedcloud"
      # version = "2.3.0-RC"
      # version = "2.2.7-fix.app.policy.15th"
      # version = "2.3.1-RC"
      # version = "2.3.1-rc2.local.dev.7"

      # Public terraform provider release: https://registry.terraform.io/providers/zededa/zedcloud/latest/docs
      source  = "zededa/zedcloud"
      version = "2.3.1-RC1"
    }
  }
}

variable "ZEDEDA_CLOUD_URL" {
  description = "ZEDEDA CLOUD URL"
  sensitive   = false
  type        = string
  default     = "" # Setting a default value makes the presence of the variable optional.
}

variable "ZEDEDA_CLOUD_TOKEN" {
  description = "ZEDEDA CLOUD API TOKEN"
  sensitive   = true
  type        = string
}

locals {
  zedcloud_url_per_workspace = {
    default = ""
    gmwtus  = "zedcloud.gmwtus.zededa.net"
    prod    = "zedcloud.zededa.net"
  }
  zedcloud_url_computed = var.ZEDEDA_CLOUD_URL != "" ? var.ZEDEDA_CLOUD_URL : local.zedcloud_url_per_workspace[terraform.workspace]
}

provider "zedcloud" {
  zedcloud_url   = local.zedcloud_url_computed
  zedcloud_token = var.ZEDEDA_CLOUD_TOKEN
}

# output "PROVIDER_ZEDCLOUD_URL" {
#  value = local.zedcloud_url_computed 
# }
