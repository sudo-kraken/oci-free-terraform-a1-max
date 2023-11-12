# Tenancy OCID Value
variable "tenancy_ocid" {}

# User OCID Value
variable "user_ocid" {}

# Fingerprint Value
variable "fp" {}

# Private Key Contents
variable "pkey_path" {}

# SSH public key to use for SSH access
variable "ssh_pub_key" {}

# Define the module source and its location                    
module "oci-a1-max" {
  source                   = "./oci-a1-max-module"
  tenancy_ocid             = var.tenancy_ocid
  user_ocid                = var.user_ocid
  compartment_name         = "oci-a1-max"
  fingerprint              = var.fp
  region                   = "uk-london-1"
  vm_name                  = "oci-a1-max-instance"
  vm_image_ocid_ampere     = "ocid1.image.oc1.uk-london-1.aaaaaaaa57kek4gtk6exlfu7yijjsa26bdmm42ibogeqi7ehwah5fxd6ybda"
  private_key_path         = var.pkey_path
  ssh_public_key           = var.ssh_pub_key
  tags                     = { Project = "oci-tf-a1-max" }

}

output "module_public_ip_ampere" {
  value = module.oci-a1-max.public-ip-ampere-instance
}
