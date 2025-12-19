terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_core_boot_volume" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  size_in_gbs         = var.size_in_gbs
  vpus_per_gb         = var.vpus_per_gb

  dynamic "source_details" {
    for_each = var.source_details == null ? [] : [var.source_details]
    content {
      type = source_details.value.type
      id   = source_details.value.id
    }
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" {
  value = oci_core_boot_volume.this.id
}

output "size_in_gbs" {
  value = oci_core_boot_volume.this.size_in_gbs
}
