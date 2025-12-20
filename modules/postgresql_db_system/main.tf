terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_postgresql_db_system" "this" {
  compartment_id  = var.compartment_id
  subnet_id       = var.subnet_id
  display_name    = var.display_name
  shape           = var.shape
  db_version      = var.db_version
  storage_size_in_gbs = var.storage_size_in_gbs

  admin_username = var.admin_username
  admin_password = var.admin_password

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_postgresql_db_system.this.id }
output "state" { value = oci_postgresql_db_system.this.state }
