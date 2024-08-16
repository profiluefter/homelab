terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~> 0.5"
    }
    oci = {
      source  = "oracle/oci"
      version = "6.7.0"
    }
  }
}

data "sops_file" "oci_credentials" {
  source_file = "secrets/oci.yaml"
}

provider "oci" {
  tenancy_ocid = data.sops_file.oci_credentials.data["tenancy_ocid"]
  user_ocid    = data.sops_file.oci_credentials.data["user_ocid"]
  private_key  = data.sops_file.oci_credentials.data["private_key"]
  fingerprint  = data.sops_file.oci_credentials.data["fingerprint"]
  region       = data.sops_file.oci_credentials.data["region"]
}

module "oracle_base" {
  source = "./modules/oracle-base"
}

data "sops_file" "proxmox_credentials" {
  source_file = "secrets/proxmox.yaml"
}

provider "proxmox" {
  pm_api_url          = data.sops_file.proxmox_credentials.data["proxmox_api_url"]
  pm_api_token_id     = data.sops_file.proxmox_credentials.data["proxmox_api_token_id"]
  pm_api_token_secret = data.sops_file.proxmox_credentials.data["proxmox_api_token_secret"]
  pm_tls_insecure     = true
}

module "talos" {
  source = "./modules/talos"

  proxmox_master_macs = [
    "C2:71:14:A0:F0:00"
  ]

  proxmox_worker_macs = [
    "C2:71:14:A0:FF:00",
    "C2:71:14:A0:FF:01"
  ]
}
