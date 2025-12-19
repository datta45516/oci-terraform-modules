terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_database_exadata_infrastructure" "this" {
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  availability_domain = var.availability_domain
  shape               = var.shape

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_database_exadata_infrastructure.this.id }
output "lifecycle_state" { value = oci_database_exadata_infrastructure.this.lifecycle_state }
