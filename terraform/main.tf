terraform {
    required_version = ">= 1.0.0"
    required_providers {
    rustack = {
      source  = "pilat/rustack"
      version = "> 1.1.0"
    }
  }
}
provider "rustack" {
    api_endpoint = "https://cloud.mephi.ru"
    token = "64ebbf040a8282d949e417efcb75c651e913d52a"
}
resource "rustack_project" "project" {
 name = "Jupyter"
}
data "rustack_hypervisor" "kvm" {
 project_id = rustack_project.project.id
 name = "kvm"
}
resource "rustack_vdc" "vdc" {
 name = "JupyterLab"
 project_id = rustack_project.project.id
 hypervisor_id = data.rustack_hypervisor.kvm.id
}
data "rustack_firewall_template" "allow_web" {
 vdc_id = rustack_vdc.vdc.id
 name = "Разрешить WEB"
}
data "rustack_firewall_template" "allow_ssh" {
 vdc_id = rustack_vdc.vdc.id
 name = "Разрешить SSH"
}
data "rustack_storage_profile" "ocfs2" {
 vdc_id = rustack_vdc.vdc.id
 name = "ocfs2"
}
data "rustack_network" "service_network" {
 vdc_id = rustack_vdc.vdc.id
 name = "Сеть"
}
data "rustack_template" "ubuntu20" {
 vdc_id = rustack_vdc.vdc.id
 name = "Ubuntu 20.04"
}
resource "rustack_port" "vm_port" {
 vdc_id = resource.rustack_vdc.vdc.id
 network_id = data.rustack_network.service_network.id
 firewall_templates = [data.rustack_firewall_template.allow_web.id]
}
resource "rustack_vm" "TerraformJupyterLab" {
 vdc_id = rustack_vdc.vdc.id
 name = "JupyterLab"
 cpu = 2
 ram = 2
 template_id = data.rustack_template.ubuntu20.id
 user_data = "${file("cloud-config.tpl")}"
  system_disk {
 size = 10
 storage_profile_id = data.rustack_storage_profile.ocfs2.id
 }
 ports = [rustack_port.vm_port.id]
 power = true
 floating = true
}




