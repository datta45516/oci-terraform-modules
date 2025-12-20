terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_functions_application" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  subnet_ids     = var.subnet_ids
  config         = var.config

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_functions_application.this.id }
output "subnet_ids" { value = oci_functions_application.this.subnet_ids }
