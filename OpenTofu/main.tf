resource "proxmox_virtual_environment_container" "uptime_kuma" {
  description = "Managed by OpenTofu"

  node_name = "yharnam"
  vm_id     = 250

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
    template_file_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    type             = "debian"
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
    hostname = "uptime-kuma"

    ip_config {
      ipv4 {
        address = "${var.uptime_kuma_ip}/24"
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