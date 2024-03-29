packer {
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = "~> 1"
    }
  }
}

variable "cpu_num" {
  type    = string
  default = ""
}

variable "disk_size" {
  type    = string
  default = ""
}

variable "mem_size" {
  type    = string
  default = ""
}

variable "os_iso_path" {
  type    = string
  default = ""
}

variable "vmtools_iso_path" {
  type    = string
  default = ""
}

variable "vsphere_compute_cluster" {
  type    = string
  default = ""
}

variable "vsphere_datastore" {
  type    = string
  default = ""
}

variable "vsphere_dc_name" {
  type    = string
  default = ""
}

variable "vsphere_folder" {
  type    = string
  default = ""
}

variable "vsphere_host" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "vsphere_portgroup_name" {
  type    = string
  default = ""
}

variable "vsphere_server" {
  type    = string
  default = ""
}

variable "vsphere_template_name" {
  type    = string
  default = ""
}

variable "vsphere_user" {
  type    = string
  default = ""
}

variable "winadmin_password" {
  type      = string
  default   = ""
  sensitive = true
}

source "vsphere-iso" "autogenerated_1" {
  CPUs                 = "${var.cpu_num}"
  RAM                  = "${var.mem_size}"
  RAM_reserve_all      = true
  cluster              = "${var.vsphere_compute_cluster}"
  communicator         = "winrm"
  convert_to_template  = "true"
  datacenter           = "${var.vsphere_dc_name}"
  datastore            = "${var.vsphere_datastore}"
  disk_controller_type = "lsilogic-sas"
  firmware             = "bios"
  floppy_files         = ["setup/win19/autounattend.xml", "setup/setup.ps1", "setup/vmtools.cmd"]
  folder               = "${var.vsphere_folder}"
  guest_os_type        = "windows2019srvNext_64Guest"
  host                 = "${var.vsphere_host}"
  insecure_connection  = "true"
  iso_paths            = ["${var.os_iso_path}", "${var.vmtools_iso_path}"]
  network_adapters {
    network      = "${var.vsphere_portgroup_name}"
    network_card = "vmxnet3"
  }
  password = "${var.vsphere_password}"
  storage {
    disk_size             = "${var.disk_size}"
    disk_thin_provisioned = true
  }
  username       = "${var.vsphere_user}"
  vcenter_server = "${var.vsphere_server}"
  vm_name        = "${var.vsphere_template_name}"
  winrm_password = "${var.winadmin_password}"
  winrm_username = "Administrator"
}

build {
  sources = ["source.vsphere-iso.autogenerated_1"]

  provisioner "windows-shell" {
    inline = ["dir c:\\"]
  }

}
