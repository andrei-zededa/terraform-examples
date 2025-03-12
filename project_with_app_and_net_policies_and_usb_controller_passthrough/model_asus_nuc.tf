# https://www.asus.com/us/displays-desktops/nucs/nuc-mini-pcs/asus-nuc-14-pro-plus/techspec/
# https://www.asus.com/Websites/us/products/wh6encdlpuphnjt8/pdf/mqaaseuzhjiyfe4d.pdf
#
# > dmidecode
# .........................
# System Information
# 	Manufacturer: ASUSTeK COMPUTER INC.
# 	Product Name: NUC14RVS-B
# 	Version: 90AR0051-M00040
# 	Serial Number: S...........................
# 	UUID: f...................................
# 	Wake-up Type: Power Switch
# 	SKU Number: NUC14RVS-B
# 	Family: RV
resource "zedcloud_model" "ASUS_NUC_14_PRO_PLUS" {
  attr = {
    "Cpus"     = "18"
    "memory"   = "63543M"
    "storage"  = "476G"
    "watchdog" = "true"
    "hsm"      = "1"
    "leds"     = "0"
  }

  brand_id       = zedcloud_brand.ASUS_NUC.id
  name           = "ASUS_NUC_14_PRO_PLUS"
  title          = "ASUS_NUC_14_PRO_PLUS"
  origin_type    = "ORIGIN_LOCAL"
  product_status = "production"
  state          = "SYS_MODEL_STATE_ACTIVE"
  type           = "AMD64"

  io_member_list {
    ztype        = "IO_TYPE_ETH"
    usage        = "ADAPTER_USAGE_MANAGEMENT"
    cost         = 0
    phylabel     = "eth0"
    logicallabel = "eth0"
    usage_policy = {}
    assigngrp    = "group18"
    phyaddrs = {
      Ifname  = "eth0"
      PciLong = "0000:56:00.0"
    }
  }
  #  io_member_list {
  #    ztype     = 7
  #    phylabel  = "VGA"
  #    assigngrp = "group0"
  #    phyaddrs = {
  #      PciLong = "0000:00:02.0"
  #    }
  #    logicallabel = "VGA"
  #    usage_policy  = {}
  #  }
  io_member_list {
    ztype     = "IO_TYPE_USB_CONTROLLER"
    cost      = 0
    phylabel  = "USB"
    assigngrp = "group9"
    phyaddrs = {
      PciLong = "0000:00:0d.0"
    }
    logicallabel = "USB"
    usage_policy = {}
  }
  io_member_list {
    ztype     = "IO_TYPE_USB_CONTROLLER"
    cost      = 0
    phylabel  = "USB1"
    assigngrp = "group9"
    phyaddrs = {
      PciLong = "0000:00:0d.2"
    }
    logicallabel = "USB1"
    usage_policy = {}
  }
  io_member_list {
    ztype     = "IO_TYPE_USB_CONTROLLER"
    cost      = 0
    phylabel  = "USB2"
    assigngrp = "group9"
    phyaddrs = {
      PciLong = "0000:00:0d.3"
    }
    logicallabel = "USB2"
    usage_policy = {}
  }
  io_member_list {
    ztype     = "IO_TYPE_USB_CONTROLLER"
    cost      = 0
    phylabel  = "USB3"
    assigngrp = "group11"
    phyaddrs = {
      PciLong = "0000:00:14.0"
    }
    logicallabel = "USB3"
    usage_policy = {}
  }
  io_member_list {
    ztype           = "IO_TYPE_USB_DEVICE"
    cost            = 0
    phylabel        = "USB-058f:6387-3:6"
    assigngrp       = "USB3-6"
    parentassigngrp = "group11"
    phyaddrs = {
      usbaddr    = "3:6"
      usbproduct = "058f:6387"
    }
    logicallabel = "USB-STICK-FRONT-RIGHT"
    usage_policy = {}
  }
  io_member_list {
    ztype           = "IO_TYPE_USB_DEVICE"
    cost            = 0
    phylabel        = "USB-8087:0033-3:10"
    assigngrp       = "USB3-10"
    parentassigngrp = "group11"
    phyaddrs = {
      usbaddr    = "3:10"
      usbproduct = "8087:0033"
    }
    logicallabel = "USB-8087:0033-3:10"
    usage_policy = {}
  }
  #  io_member_list {
  #    ztype     = 255
  #    phylabel  = "NVME"
  #    assigngrp = "group17"
  #    phyaddrs = {
  #      PciLong = "0000:01:00.0"
  #    }
  #    logicallabel = "NVME"
  #    usage_policy  = {}
  #  }
}
