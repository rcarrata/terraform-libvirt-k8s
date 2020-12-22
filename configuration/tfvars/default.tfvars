kube_master = {
  hostname = "kube-master"
  base_img = "/var/lib/libvirt/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2"
  vcpu     = 1
  memory   = 6144
}

kube_worker = {
  hostname = "kube-worker"
  base_img = "/var/lib/libvirt/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2"
  vcpu     = 1
  memory   = 4096
}