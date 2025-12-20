terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_file_storage_mount_target" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  subnet_id           = var.subnet_id
  display_name        = var.display_name
  hostname_label      = var.hostname_label
  nsg_ids             = var.nsg_ids

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_file_storage_mount_target.this.id }
output "export_set_id" { value = oci_file_storage_mount_target.this.export_set_id }
