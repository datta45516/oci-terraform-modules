terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_kms_key" "this" {
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  management_endpoint = var.management_endpoint
  protection_mode     = var.protection_mode

  key_shape {
    algorithm = var.algorithm
    length    = var.length
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_kms_key.this.id }
output "display_name" { value = oci_kms_key.this.display_name }
