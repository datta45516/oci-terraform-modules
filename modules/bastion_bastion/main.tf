terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_bastion_bastion" "this" {
  compartment_id                 = var.compartment_id
  bastion_type                   = var.bastion_type
  target_subnet_id               = var.target_subnet_id
  name                           = var.name
  client_cidr_block_allow_list   = var.client_cidr_block_allow_list
  max_session_ttl_in_seconds     = var.max_session_ttl_in_seconds

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_bastion_bastion.this.id }
output "state" { value = oci_bastion_bastion.this.state }
