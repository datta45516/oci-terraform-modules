terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_core_boot_volume_backup" "this" {
  boot_volume_id = var.boot_volume_id
  display_name   = var.display_name
  type           = var.type
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
}

output "id" {
  value = oci_core_boot_volume_backup.this.id
}

output "time_created" {
  value = oci_core_boot_volume_backup.this.time_created
}
