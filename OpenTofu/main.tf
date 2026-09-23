resource "proxmox_virtual_environment_container" "ubuntu" {
  description = "Managed by OpenTofu"

  node_name = "yharnam"
  vm_id     = 251

  tags = [
    "analytics",
    "monitoring",
  ]

  cpu {
    cores = 1
  }

  memory {
    dedicated = 1024
    swap      = 512
  }

  disk {
    datastore_id = "local-lvm"
    size         = 4
  }

  operating_system {
    template_file_id = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
    type             = "ubuntu"
  }

  unprivileged = true

  features {
    nesting = true
    fuse    = false
    keyctl  = false
    mknod   = false
  }

  #protection = true

  initialization {
    hostname = "ubuntu"

    ip_config {
      ipv4 {
        address = "${var.ubuntu_ip}/24"
        gateway = var.gateway
      }
    }

    user_account {
      keys = [
        file("../.ssh/homelab.pub")
      ]
    }
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"


    firewall = true
  }

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }

  start_on_boot = true
}