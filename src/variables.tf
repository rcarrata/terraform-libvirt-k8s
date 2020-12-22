# Libvirt configuration
variable "libvirt" {
  description = "Libvirt configuration"
  type = object({
    network   = string,
    pool      = string,
    pool_path = string
  })
}

# DNS configuration
variable "dns" {
  description = "DNS configuration"
  type = object({
    domain = string
  })
}

# Kubernetes master VM configuration
variable "kube_master" {
  description = "Configuration for Kubernetes Master virtual machine"
  type = object({
    hostname = string,
    base_img = string,
    vcpu     = number,
    memory   = number
  })
}

# Kubernetes worker VM configuration
variable "kube_worker" {
  description = "Configuration for Kubernetes Worker virtual machine"
  type = object({
    hostname = string,
    base_img = string,
    vcpu     = number,
    memory   = number
  })
}
