terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_identity_dynamic_group" "this" {
  compartment_id = var.tenancy_ocid
  name           = var.name
  description    = var.description
  matching_rule  = var.matching_rule
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
}

output "id" { value = oci_identity_dynamic_group.this.id }
output "name" { value = oci_identity_dynamic_group.this.name }
