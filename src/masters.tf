data "template_file" "kubemaster_user_data" {
  template = file("${path.module}/assets/cloud_init.cfg")
  vars = {
    hostname = "${var.kube_master.hostname}"
    fqdn     = "${var.kube_master.hostname}.${var.dns.domain}"
  }
}

data "template_file" "kubemaster_network_config" {
  template = file("${path.module}/assets/network_config.cfg")
}


resource "libvirt_volume" "kubemaster" {
  name           = "${var.kube_master.hostname}.qcow2"
  pool           = "default"
  base_volume_id = var.kube_master.base_img
  format         = "qcow2"
}

resource "libvirt_cloudinit_disk" "kubemaster_commoninit" {
  name           = "${var.kube_master.hostname}-commoninit.iso"
  pool           = "default"
  user_data      = data.template_file.kubemaster_user_data.rendered
  network_config = data.template_file.kubemaster_network_config.rendered
}

# Create the machine
resource "libvirt_domain" "kubemaster" {
  name   = var.kube_master.hostname
  memory = var.kube_master.memory
  vcpu   = var.kube_master.vcpu

  disk {
    volume_id = libvirt_volume.kubemaster.id
  }

  network_interface {
    network_name = "default"
  }

  cloudinit = libvirt_cloudinit_disk.kubemaster_commoninit.id

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
