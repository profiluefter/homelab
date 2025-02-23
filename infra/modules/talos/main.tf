terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
    oci = {
      source  = "oracle/oci"
      version = "6.27.0"
    }
  }
}
