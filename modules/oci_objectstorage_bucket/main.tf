terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_objectstorage_bucket" "this" {
  compartment_id = var.compartment_id
  namespace      = var.namespace
  name           = var.name

  access_type  = var.access_type
  storage_tier = var.storage_tier

  versioning   = var.versioning
  auto_tiering = var.auto_tiering

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_objectstorage_bucket.this.id }
output "name" { value = oci_objectstorage_bucket.this.name }
