output "public-ip-ampere-instance" {
  description = "The public IP address assigned to the A1 instance"
  value = oci_core_instance.vm_instance_ampere.public_ip
}

output "private-ip-ampere-instance" {
  description = "The private IP address assigned to the A1 instance"
  value = oci_core_instance.vm_instance_ampere.private_ip
}

output "instance-id-ampere-instance" {
  description = "The OCID of the A1 instance"
  value = oci_core_instance.vm_instance_ampere.id
}
