
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
# Data Sources
# -----------------------------------------------------------------------------

data "oci_core_services" "all_services" {
  filter {
    name   = "name"
    values = [var.service_name_pattern]
    regex  = true
  }
}

# -----------------------------------------------------------------------------
# Service Gateway Resource
# -----------------------------------------------------------------------------

resource "oci_core_service_gateway" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.display_name
  route_table_id = var.route_table_id

  services {
    service_id = var.service_id != null ? var.service_id : data.oci_core_services.all_services.services[0].id
  }

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
  description = "The OCID of the Service Gateway"
  value       = oci_core_service_gateway.this.id
}

output "display_name" {
  description = "The display name of the Service Gateway"
  value       = oci_core_service_gateway.this.display_name
}

output "state" {
  description = "The current state of the Service Gateway"
  value       = oci_core_service_gateway.this.state
}

output "services" {
  description = "List of services enabled on this gateway"
  value       = oci_core_service_gateway.this.services
}

output "block_traffic" {
  description = "Whether the gateway is blocked"
  value       = oci_core_service_gateway.this.block_traffic
}

output "available_services" {
  description = "Available services for the gateway"
  value       = data.oci_core_services.all_services.services
}
