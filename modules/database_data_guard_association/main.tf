terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_database_data_guard_association" "this" {
  database_id              = var.database_id
  creation_type            = var.creation_type
  database_admin_password  = var.database_admin_password
  protection_mode          = var.protection_mode
  transport_type           = var.transport_type

  peer_db_system_id        = var.peer_db_system_id

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_database_data_guard_association.this.id }
output "lifecycle_state" { value = oci_database_data_guard_association.this.lifecycle_state }
