
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
# DRG Resource
# -----------------------------------------------------------------------------

resource "oci_core_drg" "this" {
  compartment_id = var.compartment_id
  display_name   = var.drg_display_name

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# DRG Attachments
# -----------------------------------------------------------------------------

resource "oci_core_drg_attachment" "vcn_attachments" {
  for_each = var.vcn_attachments

  drg_id             = oci_core_drg.this.id
  display_name       = each.value.display_name
  drg_route_table_id = lookup(each.value, "drg_route_table_id", null)

  network_details {
    id             = each.value.vcn_id
    type           = "VCN"
    route_table_id = lookup(each.value, "vcn_route_table_id", null)
  }

  freeform_tags = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
  defined_tags  = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# DRG Route Tables
# -----------------------------------------------------------------------------

resource "oci_core_drg_route_table" "this" {
  for_each = var.drg_route_tables

  drg_id                           = oci_core_drg.this.id
  display_name                     = each.value.display_name
  import_drg_route_distribution_id = lookup(each.value, "import_drg_route_distribution_id", null)
  is_ecmp_enabled                  = lookup(each.value, "is_ecmp_enabled", false)

  freeform_tags = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
  defined_tags  = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# DRG Route Table Route Rules
# -----------------------------------------------------------------------------

resource "oci_core_drg_route_table_route_rule" "this" {
  for_each = var.drg_route_rules

  drg_route_table_id         = lookup(each.value, "drg_route_table_id", oci_core_drg_route_table.this[each.value.route_table_key].id)
  destination                = each.value.destination
  destination_type           = lookup(each.value, "destination_type", "CIDR_BLOCK")
  next_hop_drg_attachment_id = each.value.next_hop_drg_attachment_id
}

# -----------------------------------------------------------------------------
# DRG Route Distributions
# -----------------------------------------------------------------------------

resource "oci_core_drg_route_distribution" "this" {
  for_each = var.drg_route_distributions

  drg_id            = oci_core_drg.this.id
  display_name      = each.value.display_name
  distribution_type = each.value.distribution_type

  freeform_tags = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
  defined_tags  = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# DRG Route Distribution Statements
# -----------------------------------------------------------------------------

resource "oci_core_drg_route_distribution_statement" "this" {
  for_each = var.drg_distribution_statements

  drg_route_distribution_id = lookup(each.value, "drg_route_distribution_id", oci_core_drg_route_distribution.this[each.value.distribution_key].id)
  action                    = each.value.action
  priority                  = each.value.priority

  dynamic "match_criteria" {
    for_each = lookup(each.value, "match_criteria", null) != null ? [each.value.match_criteria] : []
    content {
      match_type        = match_criteria.value.match_type
      attachment_type   = lookup(match_criteria.value, "attachment_type", null)
      drg_attachment_id = lookup(match_criteria.value, "drg_attachment_id", null)
    }
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "drg_id" {
  description = "The OCID of the DRG"
  value       = oci_core_drg.this.id
}

output "drg_display_name" {
  description = "The display name of the DRG"
  value       = oci_core_drg.this.display_name
}

output "drg_default_route_table_id" {
  description = "The OCID of the default DRG route table"
  value       = oci_core_drg.this.default_drg_route_tables[0].vcn
}

output "drg_default_export_route_distribution_id" {
  description = "The OCID of the default export route distribution"
  value       = oci_core_drg.this.default_export_drg_route_distribution_id
}

output "vcn_attachment_ids" {
  description = "Map of VCN attachment names to their OCIDs"
  value       = { for k, v in oci_core_drg_attachment.vcn_attachments : k => v.id }
}

output "drg_route_table_ids" {
  description = "Map of DRG route table names to their OCIDs"
  value       = { for k, v in oci_core_drg_route_table.this : k => v.id }
}

output "drg_route_distribution_ids" {
  description = "Map of DRG route distribution names to their OCIDs"
  value       = { for k, v in oci_core_drg_route_distribution.this : k => v.id }
}
