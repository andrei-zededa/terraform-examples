terraform {
  required_providers {
    # A locally built version of the Zedcloud TF provider needs to be copied as
    # the $HOME/.terraform.d/plugins/localhost/zededa/zedcloud/$VERSION/linux_amd64/terraform-provider-zedcloud
    # file (make user it's executable).
    zedcloud = {
      # source = "localhost/zededa/zedcloud"
      # version = "2.3.0-RC"
      # version = "2.2.7-fix.app.policy.15th"
      # version = "2.3.1-RC"
      # version = "2.3.1-rc2.local.dev.7"

      # Public terraform provider release: https://registry.terraform.io/providers/zededa/zedcloud/latest/docs
      source  = "zededa/zedcloud"
      version = "2.3.1-rc2"
    }
  }
}

variable "ZEDEDA_CLOUD_URL" {
  description = "ZEDEDA CLOUD URL"
  sensitive   = false
  type        = string
}

variable "ZEDEDA_CLOUD_TOKEN" {
  description = "ZEDEDA CLOUD API TOKEN"
  sensitive   = true
  type        = string
}

provider "zedcloud" {
  zedcloud_url   = var.ZEDEDA_CLOUD_URL
  zedcloud_token = var.ZEDEDA_CLOUD_TOKEN
}
