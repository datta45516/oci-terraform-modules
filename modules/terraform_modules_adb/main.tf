terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_database_autonomous_database" "this" {
  compartment_id           = var.compartment_id
  db_name                  = var.db_name
  display_name             = var.display_name
  db_workload              = var.db_workload
  cpu_core_count           = var.cpu_core_count
  data_storage_size_in_tbs = var.data_storage_size_in_tbs
  admin_password           = var.admin_password
  is_free_tier             = var.is_free_tier
  subnet_id                = var.subnet_id
  nsg_ids                  = var.nsg_ids

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" {
  value = oci_database_autonomous_database.this.id
}

output "connection_strings" {
  value = oci_database_autonomous_database.this.connection_strings
}
