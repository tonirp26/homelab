resource "proxmox_virtual_environment_container" "homarr" {
  description = "Managed by OpenTofu"

  node_name = "yharnam"
  vm_id     = var.homarr_id
  tags = ["dashboard","arr"]
  unprivileged = true

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
    swap      = 512
  }

  disk {
    datastore_id = "local-lvm"
    size         = 8
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    type             = "debian"
  }

  features {
    nesting = true
    fuse    = false
    keyctl  = false
    mknod   = false
  }

  #protection = true

  initialization {
    hostname = var.homarr_hostname

    ip_config {
      ipv4 {
        address = "${var.homarr_ip}/24"
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
    order      = "-1"
    up_delay   = "60"
    down_delay = "60"
  }

  start_on_boot = true
}