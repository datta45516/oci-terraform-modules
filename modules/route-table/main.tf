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
# Route Table Resources
# -----------------------------------------------------------------------------

resource "oci_core_route_table" "this" {
  for_each = var.route_tables

  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = each.value.display_name

  dynamic "route_rules" {
    for_each = lookup(each.value, "route_rules", [])
    content {
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = lookup(route_rules.value, "destination_type", "CIDR_BLOCK")
      description       = lookup(route_rules.value, "description", null)
      route_type        = lookup(route_rules.value, "route_type", null)
    }
  }

  freeform_tags = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
  defined_tags  = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# Default Route Table Management
# -----------------------------------------------------------------------------

resource "oci_core_default_route_table" "this" {
  count = var.manage_default_route_table ? 1 : 0

  manage_default_resource_id = var.default_route_table_id
  display_name               = var.default_route_table_display_name

  dynamic "route_rules" {
    for_each = var.default_route_table_rules
    content {
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = lookup(route_rules.value, "destination_type", "CIDR_BLOCK")
      description       = lookup(route_rules.value, "description", null)
    }
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

output "route_table_ids" {
  description = "Map of route table names to their OCIDs"
  value       = { for k, v in oci_core_route_table.this : k => v.id }
}

output "route_tables" {
  description = "All route table attributes"
  value       = oci_core_route_table.this
}

output "default_route_table_id" {
  description = "The OCID of the managed default route table"
  value       = var.manage_default_route_table ? oci_core_default_route_table.this[0].id : null
}
