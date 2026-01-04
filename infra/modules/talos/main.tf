terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc07"
    }
    oci = {
      source  = "oracle/oci"
      version = "6.7.0"
    }
  }
}
