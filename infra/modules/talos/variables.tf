variable "proxmox_master_macs" {
  description = "MAC addresses for the Talos master nodes"
  type = list(string)
}

variable "proxmox_worker_macs" {
  description = "MAC addresses for the Talos worker nodes"
  type = list(string)
}

variable "oci_compartment_id" {
  description = "OCID of the compartment for the Talos resources"
  type        = string
}

variable "oci_vcn_id" {
  description = "OCID of the VCN used for the Talos resources"
  type        = string
}

variable "oci_instance_availability_domain" {
  description = "Availability domain to use for the Talos worker nodes"
  type        = string
  default     = "AD-3"
}
