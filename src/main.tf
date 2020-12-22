terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.2"
    }
  }
  backend "local" {}

}

# instance the provider
provider "libvirt" {
  uri = "qemu+ssh://root@iron.rcarrata.com/system"
}
