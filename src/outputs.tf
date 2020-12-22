output "kube-master-ips" {
  # show IP, run 'terraform refresh' if not populated
  value = libvirt_domain.kubemaster.*.network_interface.0.addresses
}
