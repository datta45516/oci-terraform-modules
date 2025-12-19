terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_nosql_table" "this" {
  compartment_id = var.compartment_id
  name           = var.name
  ddl_statement  = var.ddl_statement

  table_limits {
    max_read_units     = var.max_read_units
    max_write_units    = var.max_write_units
    max_storage_in_gbs = var.max_storage_in_gbs
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_nosql_table.this.id }
output "state" { value = oci_nosql_table.this.state }
