terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_database_autonomous_container_database" "this" {
  compartment_id           = var.compartment_id
  display_name             = var.display_name
  autonomous_vm_cluster_id  = var.autonomous_vm_cluster_id
  patch_model              = var.patch_model

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_database_autonomous_container_database.this.id }
output "lifecycle_state" { value = oci_database_autonomous_container_database.this.lifecycle_state }
