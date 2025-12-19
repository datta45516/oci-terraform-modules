terraform {
  required_version = ">= 1.5.0"
  required_providers {
    oci = { source = "oracle/oci", version = ">= 5.0.0" }
  }
}

resource "oci_core_image" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name

  # One of instance_id OR image_source_details should be set.
  instance_id = var.instance_id

  dynamic "image_source_details" {
    for_each = var.image_source_details == null ? [] : [var.image_source_details]
    content {
      source_type = image_source_details.value.source_type
      source_uri  = image_source_details.value.source_uri
    }
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" {
  value = oci_core_image.this.id
}

output "time_created" {
  value = oci_core_image.this.time_created
}
