# Output the "list" of all availability domains.
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

output "compartment-name" {
  value = oci_identity_compartment.oci_a1_max.name
}

output "public-ip-ampere-instance" {
  value = oci_core_instance.vm_instance_ampere.public_ip
}
