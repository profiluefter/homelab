# only used for initial installation. vm will be bootet from this and then initialized using talosctl
resource "proxmox_storage_iso" "talos-iso" {
  pve_node = "thought"

  storage  = "local"
  filename = "talos-1.6.7-metal-amd64.iso"

  url = "https://github.com/siderolabs/talos/releases/download/v1.6.7/metal-amd64.iso"

  checksum_algorithm = "sha512"
  checksum           = ":cb289716511e1a2a1a580160daee90f3858e84e3233057c125af6f5fef1cf3d70d4bf9f1b539d5b94aaa96cc4ff17439d137ef15182645b61cef29f1346e4114"
}

resource "proxmox_vm_qemu" "talos_master" {
  for_each = {for mac in var.proxmox_master_macs : index(var.proxmox_master_macs, mac) => mac}

  qemu_os = "l26"

  target_node = "thought"
  onboot = true

  name = "talos-master-${each.key + 1}"
  desc = "Talos Master Node ${each.key + 1}"
  tags = "talos"

  memory  = 4096
  balloon = 2048
  cores   = 2

  cpu = "x86-64-v2-AES"

  boot  = "order=scsi0"
  agent = 1

  scsihw = "virtio-scsi-pci"
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "fast"
          size    = 20
        }
      }
    }
  }

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    macaddr = each.value
  }
}

resource "proxmox_vm_qemu" "talos_worker" {
  for_each = {for mac in var.proxmox_worker_macs : index(var.proxmox_worker_macs, mac) => mac}

  qemu_os = "l26"

  target_node = "thought"
  onboot = true

  name = "talos-worker-${each.key + 1}"
  desc = "Talos Worker Node ${each.key + 1}"
  tags = "talos"

  memory  = 6144
  balloon = 4096
  cores   = 3

  cpu = "x86-64-v2-AES"

  boot  = "order=scsi0"
  agent = 1

  scsihw = "virtio-scsi-pci"
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "fast"
          size    = 50
        }
      }
    }
  }

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    macaddr = each.value
  }
}
