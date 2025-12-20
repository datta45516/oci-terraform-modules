terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_artifacts_container_repository" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  is_public      = var.is_public
  is_immutable   = var.is_immutable

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_artifacts_container_repository.this.id }
output "repository_url" { value = oci_artifacts_container_repository.this.repository_url }
