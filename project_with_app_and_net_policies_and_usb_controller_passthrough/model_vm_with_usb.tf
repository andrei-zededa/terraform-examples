resource "zedcloud_model" "VM_WITH_MANY_PORTS_AND_USB" {
  attr = {
    "Cpus"    = "4"
    "memory"  = "8192M"
    "storage" = "100G"
  }
  brand_id       = zedcloud_brand.QEMU_VM.id
  name           = "VM_WITH_MANY_PORTS_AND_USB"
  origin_type    = "ORIGIN_LOCAL"
  product_status = "production"
  state          = "SYS_MODEL_STATE_ACTIVE"
  title          = "VM_WITH_MANY_PORTS_AND_USB"
  type           = "AMD64"

  io_member_list {
    assigngrp    = "COM1"
    cbattr       = {}
    cost         = 0
    logicallabel = "COM1"
    phyaddrs = {
      Serial = "/dev/ttyS0"
    }
    phylabel     = "COM1"
    usage        = "ADAPTER_USAGE_UNSPECIFIED"
    usage_policy = {}
    ztype        = "IO_TYPE_COM"
  }
  io_member_list {
    assigngrp    = "COM2"
    cbattr       = {}
    cost         = 0
    logicallabel = "COM2"
    phyaddrs = {
      Serial = "/dev/ttyS1"
    }
    phylabel     = "COM2"
    usage        = "ADAPTER_USAGE_UNSPECIFIED"
    usage_policy = {}
    ztype        = "IO_TYPE_COM"
  }
  io_member_list {
    assigngrp    = "COM3"
    cbattr       = {}
    cost         = 0
    logicallabel = "COM3"
    phyaddrs = {
      Serial = "/dev/ttyS2"
    }
    phylabel     = "COM3"
    usage        = "ADAPTER_USAGE_UNSPECIFIED"
    usage_policy = {}
    ztype        = "IO_TYPE_COM"
  }
  io_member_list {
    assigngrp    = "COM4"
    cbattr       = {}
    cost         = 0
    logicallabel = "COM4"
    phyaddrs = {
      Serial = "/dev/ttyS3"
    }
    phylabel     = "COM4"
    usage        = "ADAPTER_USAGE_UNSPECIFIED"
    usage_policy = {}
    ztype        = "IO_TYPE_COM"
  }
  io_member_list {
    assigngrp    = "eth0"
    cbattr       = {}
    cost         = 0
    logicallabel = "first_physical_intf"
    phyaddrs = {
      Ifname = "eth0"
    }
    phylabel     = "eth0"
    usage        = "ADAPTER_USAGE_MANAGEMENT"
    usage_policy = {}
    ztype        = "IO_TYPE_ETH"
  }
  io_member_list {
    assigngrp    = "eth1"
    cbattr       = {}
    cost         = 0
    logicallabel = "2nd_physical_intf"
    phyaddrs = {
      Ifname = "eth1"
    }
    phylabel     = "eth1"
    usage        = "ADAPTER_USAGE_UNSPECIFIED"
    usage_policy = {}
    ztype        = "IO_TYPE_ETH"
  }
  io_member_list {
    assigngrp    = "eth2"
    cbattr       = {}
    cost         = 0
    logicallabel = "3rd_physical_intf"
    phyaddrs = {
      Ifname = "eth2"
    }
    phylabel     = "eth2"
    usage        = "ADAPTER_USAGE_UNSPECIFIED"
    usage_policy = {}
    ztype        = "IO_TYPE_ETH"
  }
  io_member_list {
    assigngrp    = "eth3"
    cbattr       = {}
    cost         = 0
    logicallabel = "4th_physical_intf"
    phyaddrs = {
      Ifname = "eth3"
    }
    phylabel     = "eth3"
    usage        = "ADAPTER_USAGE_UNSPECIFIED"
    usage_policy = {}
    ztype        = "IO_TYPE_ETH"
  }

  io_member_list {
    ztype     = "IO_TYPE_USB_CONTROLLER"
    phylabel  = "USB"
    assigngrp = "USB0_group"
    cost      = 0
    phyaddrs = {
      PciLong = "0000:00:04.0"
    }
    logicallabel = "USB"
    # description  = "USB controller: Red Hat, Inc. QEMU XHCI Host Controller (rev 01)"
    usage_policy = {}
    # class        = "0c03"
    # vendor       = "1b36"
    # device       = "000d"
  }

  io_member_list {
    ztype     = "IO_TYPE_USB_CONTROLLER"
    phylabel  = "USB1"
    assigngrp = "USB1_group"
    cost      = 0
    phyaddrs = {
      PciLong = "0000:00:05.0"
    }
    logicallabel = "USB1"
    # description  = "USB controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 10)"
    usage_policy = {}
    # class        = "0c03"
    # vendor       = "8086"
    # device       = "24cd"
  }

  io_member_list {
    ztype           = "IO_TYPE_USB_DEVICE"
    phylabel        = "USB-46f4:0001-1:1"
    assigngrp       = "USB1-1"
    parentassigngrp = "USB1_group"
    cost            = 0
    phyaddrs = {
      usbaddr    = "1:1"
      usbproduct = "46f4:0001"
    }
    logicallabel = "USB-46f4:0001-1:1"
    usage_policy = {}
  }
}
