resource "proxmox_virtual_environment_container" "sonarr" {
  description = "Managed by OpenTofu"

  node_name = "yharnam"
  vm_id     = var.sonarr_id
  unprivileged = true
  tags = ["arr"]

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
    swap      = 512
  }

  disk {
    datastore_id = "local-lvm"
    size         = 4
  }

  # Proxmox only allow create mount points with root user.
  # mount_point{
  #   volume = "/amygdala/data"
  #   path = "/mnt/data"
  # }

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
    hostname = var.sonarr_hostname

    ip_config {
      ipv4 {
        address = "${var.sonarr_ip}/24"
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