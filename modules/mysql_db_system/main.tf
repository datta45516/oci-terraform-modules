terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_mysql_mysql_db_system" "this" {
  compartment_id        = var.compartment_id
  subnet_id             = var.subnet_id
  display_name          = var.display_name
  shape_name            = var.shape_name
  mysql_version         = var.mysql_version
  data_storage_size_in_gb = var.data_storage_size_in_gb

  admin_username = var.admin_username
  admin_password = var.admin_password

  configuration_id = var.configuration_id

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_mysql_mysql_db_system.this.id }
output "ip_address" { value = oci_mysql_mysql_db_system.this.ip_address }
