terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_identity_policy" "this" {
  compartment_id = var.compartment_id
  name           = var.name
  description    = var.description
  statements     = var.statements
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
}

output "id" { value = oci_identity_policy.this.id }
output "name" { value = oci_identity_policy.this.name }
