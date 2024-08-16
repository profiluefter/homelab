terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

# only used for initial installation. version and additional system extensions will be managed using talosctl
resource "proxmox_storage_iso" "talos-iso" {
  pve_node = "thought"

  storage  = "local"
  filename = "talos-1.6.7-metal-amd64.iso"

  url = "https://github.com/siderolabs/talos/releases/download/v1.6.7/metal-amd64.iso"

  checksum_algorithm = "sha512"
  checksum           = ":cb289716511e1a2a1a580160daee90f3858e84e3233057c125af6f5fef1cf3d70d4bf9f1b539d5b94aaa96cc4ff17439d137ef15182645b61cef29f1346e4114"
}

resource "proxmox_vm_qemu" "talos_master" {
  for_each = {for mac in var.proxmox_master_macs: index(var.proxmox_master_macs, mac) => mac}

  depends_on = [proxmox_storage_iso.talos-iso]
  iso = "${proxmox_storage_iso.talos-iso.storage}:iso/${proxmox_storage_iso.talos-iso.filename}"
  qemu_os = "l26"

  target_node = "thought"

  name = "talos-master-${each.key + 1}"
  desc = "Talos Master Node ${each.key + 1}"
  tags = "talos"

  memory = 4096
  balloon = 2048
  cores  = 2

  cpu = "x86-64-v2-AES"

  boot = "order=scsi0;ide2"
  agent = 1

  scsihw = "virtio-scsi-pci"
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = 20
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
    macaddr = each.value
  }
}

resource "proxmox_vm_qemu" "talos_worker" {
  for_each = {for mac in var.proxmox_worker_macs: index(var.proxmox_worker_macs, mac) => mac}

  depends_on = [proxmox_storage_iso.talos-iso]
  iso = "${proxmox_storage_iso.talos-iso.storage}:iso/${proxmox_storage_iso.talos-iso.filename}"
  qemu_os = "l26"

  target_node = "thought"

  name = "talos-worker-${each.key + 1}"
  desc = "Talos Worker Node ${each.key + 1}"
  tags = "talos"

  memory = 4096
  balloon = 2048
  cores  = 3

  cpu = "x86-64-v2-AES"

  boot = "order=scsi0;ide2"
  agent = 1

  scsihw = "virtio-scsi-pci"
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = 20
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
    macaddr = each.value
  }
}
