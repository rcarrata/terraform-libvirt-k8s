data "template_file" "kubeworker_user_data" {
  template = file("${path.module}/assets/cloud_init.cfg")
  vars = {
    hostname = "${var.kube_worker.hostname}"
    fqdn     = "${var.kube_worker.hostname}.${var.dns.domain}"
  }
}

data "template_file" "kubeworker_network_config" {
  template = file("${path.module}/assets/network_config.cfg")
}

resource "libvirt_volume" "kubeworker" {
  name           = "${var.kube_worker.hostname}.qcow2"
  pool           = "default"
  base_volume_id = var.kube_worker.base_img
  format         = "qcow2"
}

resource "libvirt_cloudinit_disk" "kubeworker_commoninit" {
  name           = "${var.kube_worker.hostname}-commoninit.iso"
  pool           = "default"
  user_data      = data.template_file.kubeworker_user_data.rendered
  network_config = data.template_file.kubeworker_network_config.rendered
}

# Create the machine
resource "libvirt_domain" "kubeworker" {
  name   = var.kube_worker.hostname
  memory = var.kube_worker.memory
  vcpu   = var.kube_worker.vcpu

  disk {
    volume_id = libvirt_volume.kubeworker.id
  }

  network_interface {
    network_name = "default"
  }

  cloudinit = libvirt_cloudinit_disk.kubeworker_commoninit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = "true"
  }
}
