
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

# -----------------------------------------------------------------------------
# Internet Gateway Resource
# -----------------------------------------------------------------------------

resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.display_name
  enabled        = var.enabled
  route_table_id = var.route_table_id

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "id" {
  description = "The OCID of the Internet Gateway"
  value       = oci_core_internet_gateway.this.id
}

output "display_name" {
  description = "The display name of the Internet Gateway"
  value       = oci_core_internet_gateway.this.display_name
}

output "state" {
  description = "The current state of the Internet Gateway"
  value       = oci_core_internet_gateway.this.state
}

output "time_created" {
  description = "The date and time the Internet Gateway was created"
  value       = oci_core_internet_gateway.this.time_created
}

output "enabled" {
  description = "Whether the Internet Gateway is enabled"
  value       = oci_core_internet_gateway.this.enabled
}
