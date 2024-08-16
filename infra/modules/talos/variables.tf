variable "proxmox_master_macs" {
  description = "MAC addresses for the Talos master nodes"
  type        = list(string)
}

variable "proxmox_worker_macs" {
  description = "MAC addresses for the Talos worker nodes"
  type        = list(string)
}
