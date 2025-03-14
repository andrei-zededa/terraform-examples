resource "zedcloud_application" "ubuntu_3nic_test_aaaa" {
  name  = "ubuntu_3nic_test_aaaa"
  title = "ubuntu_3nic_test_aaaa"

  # We need to explicitly declare this dependency as the *link* to the image
  # is in the manifest.json which TF doesn't parse.
  depends_on = [
    zedcloud_image.ubuntu_24_04_with_modbus_disk_999MB
  ]

  # NOTE: manifest.json has the image ID hard-coded however that seems to be
  # ignored in favor of the image name which is also hard-coded in manifest.json .
  # The image ID is updated correctly to match zedcloud_image.ubuntu_24_04_with_modbus_disk_999MB .
  manifest_file = "edge_apps/ubuntu_3nic_test_aaaa/manifest.json"
}

resource "zedcloud_application" "ubuntu_3nic_test_bbbb" {
  name  = "ubuntu_3nic_test_bbbb"
  title = "ubuntu_3nic_test_bbbb"

  # App config including manifest created by first creating it using a manifest.json
  # (which can be exported with `zcli`) and then `terraform state show ...` on that.

  networks    = 3
  origin_type = "ORIGIN_LOCAL"

  manifest {
    ac_kind             = "VMManifest"
    ac_version          = "1.2.0"
    app_type            = "APP_TYPE_VM"
    cpu_pinning_enabled = false
    deployment_type     = "DEPLOYMENT_TYPE_STAND_ALONE"
    enablevnc           = true
    name                = "ubuntu_3nic_test_bbbb"
    vmmode              = "HV_HVM"

    images {
      cleartext   = true
      drvtype     = "HDD"
      imageformat = "QCOW2"
      imageid     = zedcloud_image.ubuntu_24_04_with_modbus_disk_999MB.id
      imagename   = zedcloud_image.ubuntu_24_04_with_modbus_disk_999MB.name
      maxsize     = "10485760"
      mountpath   = "/"
      ignorepurge = true
      preserve    = false
      readonly    = false
      target      = "Disk"
    }

    interfaces {
      directattach = false
      name         = "app_eth0"
      optional     = false
      privateip    = false

      acls {
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
      acls {
        actions {
          drop       = false
          limit      = false
          limitburst = 0
          limitrate  = 0
          portmap    = true

          portmapto {
            app_port = 22
          }
        }
        matches {
          type  = "protocol"
          value = "tcp"
        }
        matches {
          type  = "lport"
          value = "10023"
        }
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
    }
    interfaces {
      directattach = false
      name         = "app_eth1"
      optional     = false
      privateip    = false

      acls {
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
    }
    interfaces {
      directattach = false
      name         = "app_eth2"
      optional     = false
      privateip    = false

      acls {
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
    }

    owner {
      email   = "help@zededa.com"
      user    = "Andrei Radu"
      website = "help.zededa.com"
    }

    resources {
      name  = "resourceType"
      value = "Custom"
    }
    resources {
      name  = "cpus"
      value = "1"
    }
    resources {
      name  = "memory"
      value = "393216.00"
    }
    resources {
      name  = "storage"
      value = "10485760.00"
    }
  }
}

resource "zedcloud_application" "ubuntu_3nic_usb_ctrl_pass" {
  name  = "ubuntu_3nic_usb_ctrl_pass"
  title = "ubuntu_3nic_usb_ctrl_pass"

  # App config including manifest created by first creating it using a manifest.json
  # (which can be exported with `zcli`) and then `terraform state show ...` on that.

  networks    = 4
  origin_type = "ORIGIN_LOCAL"

  manifest {
    ac_kind             = "VMManifest"
    ac_version          = "1.2.0"
    app_type            = "APP_TYPE_VM"
    cpu_pinning_enabled = false
    deployment_type     = "DEPLOYMENT_TYPE_STAND_ALONE"
    enablevnc           = true
    name                = "ubuntu_3nic_usb_ctrl_pass"
    vmmode              = "HV_HVM"

    images {
      cleartext   = true
      drvtype     = "HDD"
      imageformat = "QCOW2"
      imageid     = zedcloud_image.ubuntu_24_04_with_modbus_disk_999MB.id
      imagename   = zedcloud_image.ubuntu_24_04_with_modbus_disk_999MB.name
      maxsize     = "10485760"
      mountpath   = "/"
      ignorepurge = true
      preserve    = false
      readonly    = false
      target      = "Disk"
    }

    interfaces {
      directattach = false
      name         = "app_eth0"
      optional     = false
      privateip    = false

      acls {
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
      acls {
        actions {
          drop       = false
          limit      = false
          limitburst = 0
          limitrate  = 0
          portmap    = true

          portmapto {
            app_port = 22
          }
        }
        matches {
          type  = "protocol"
          value = "tcp"
        }
        matches {
          type  = "lport"
          value = "10024"
        }
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
    }

    interfaces {
      directattach = false
      name         = "app_eth1"
      optional     = false
      privateip    = false

      acls {
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
    }

    interfaces {
      directattach = false
      name         = "app_eth2"
      optional     = false
      privateip    = false

      acls {
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
    }

    interfaces {
      directattach = true
      name         = "usb_controller"
      type         = "IO_TYPE_USB_CONTROLLER"
      optional     = false
      privateip    = false
    }

    interfaces {
      directattach = true
      name         = "usb_controller_maybe"
      type         = "IO_TYPE_USB_CONTROLLER"
      # `optional = true` means that when an edge-app-instance is created using
      # this application, the edge-app-instance can skip specifying this interface
      # in which case the edge-app-instance will be started successfully but this
      # will be missing.
      optional     = true
      privateip    = false
    }

    owner {
      email   = "help@zededa.com"
      user    = "Andrei Radu"
      website = "help.zededa.com"
    }

    resources {
      name  = "resourceType"
      value = "Custom"
    }
    resources {
      name  = "cpus"
      value = "1"
    }
    resources {
      name  = "memory"
      value = "393216.00"
    }
    resources {
      name  = "storage"
      value = "10485760.00"
    }
  }
}
