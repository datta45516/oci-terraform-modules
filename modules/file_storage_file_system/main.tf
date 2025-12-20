terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_file_storage_file_system" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  defined_tags        = var.defined_tags
  freeform_tags       = var.freeform_tags
}

output "id" { value = oci_file_storage_file_system.this.id }
output "display_name" { value = oci_file_storage_file_system.this.display_name }
