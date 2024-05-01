resource "proxmox_storage_iso" "talos-iso" {
  pve_node = "thought"

  storage  = "local"
  filename = "talos-1.6.7-metal-amd64.iso"

  url = "https://github.com/siderolabs/talos/releases/download/v1.6.7/metal-amd64.iso"

  checksum_algorithm = "sha512"
  checksum           = ":cb289716511e1a2a1a580160daee90f3858e84e3233057c125af6f5fef1cf3d70d4bf9f1b539d5b94aaa96cc4ff17439d137ef15182645b61cef29f1346e4114"
}

locals {
  talos_master_macs = [
    "C2:71:14:A0:F0:00"
  ]

  talos_worker_macs = [
    "C2:71:14:A0:FF:00",
    "C2:71:14:A0:FF:01"
  ]
}

resource "proxmox_vm_qemu" "talos_master" {
  for_each = {for mac in local.talos_master_macs: index(local.talos_master_macs, mac) => mac}

  depends_on = [proxmox_storage_iso.talos-iso]
  iso = "${proxmox_storage_iso.talos-iso.storage}:iso/${proxmox_storage_iso.talos-iso.filename}"
  qemu_os = "l26"

  target_node = "thought"

  name = "talos-master-${each.key + 1}"
  desc = "Talos Master Node ${each.key + 1}"
  tags = "talos"

  memory = 4096
  cores  = 2

  cpu = "x86-64-v2-AES"

  boot = "order=scsi0;ide2"

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
  for_each = {for mac in local.talos_worker_macs: index(local.talos_worker_macs, mac) => mac}

  depends_on = [proxmox_storage_iso.talos-iso]
  iso = "${proxmox_storage_iso.talos-iso.storage}:iso/${proxmox_storage_iso.talos-iso.filename}"
  qemu_os = "l26"

  target_node = "thought"

  name = "talos-worker-${each.key + 1}"
  desc = "Talos Worker Node ${each.key + 1}"
  tags = "talos"

  memory = 2048
  cores  = 2

  cpu = "x86-64-v2-AES"

  boot = "order=scsi0;ide2"

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
