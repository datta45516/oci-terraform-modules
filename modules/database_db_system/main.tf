terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_database_db_system" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  subnet_id           = var.subnet_id

  display_name      = var.display_name
  hostname          = var.hostname
  shape             = var.shape
  cpu_core_count    = var.cpu_core_count
  node_count        = var.node_count
  database_edition  = var.database_edition
  license_model     = var.license_model
  ssh_public_keys   = var.ssh_public_keys
  data_storage_size_in_gb = var.data_storage_size_in_gb

  nsg_ids = var.nsg_ids
  domain  = var.domain

  db_home {
    display_name = var.db_home_display_name
    db_version   = var.db_version

    database {
      admin_password = var.db_admin_password
      db_name        = var.db_name
      pdb_name       = var.pdb_name
      character_set  = var.character_set
      ncharacter_set = var.ncharacter_set
    }
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" {
  value = oci_database_db_system.this.id
}

output "database_edition" {
  value = oci_database_db_system.this.database_edition
}
