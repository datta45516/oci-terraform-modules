terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_identity_compartment" "this" {
  count          = var.create_compartment ? 1 : 0
  compartment_id = var.parent_compartment_id
  name           = var.compartment_name
  description    = var.compartment_description
  enable_delete  = var.enable_delete
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
}

locals {
  policy_compartment_id = var.policy_compartment_id != null ? var.policy_compartment_id : (
    var.create_compartment ? oci_identity_compartment.this[0].id : var.parent_compartment_id
  )
}

resource "oci_identity_dynamic_group" "this" {
  count         = var.create_dynamic_group ? 1 : 0
  compartment_id = var.tenancy_ocid
  name          = var.dynamic_group_name
  description   = var.dynamic_group_description
  matching_rule = var.matching_rule
  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

resource "oci_identity_policy" "this" {
  count          = var.create_policy ? 1 : 0
  compartment_id = local.policy_compartment_id
  name           = var.policy_name
  description    = var.policy_description
  statements     = var.policy_statements
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
}

output "compartment_id" {
  value = var.create_compartment ? oci_identity_compartment.this[0].id : null
}

output "dynamic_group_id" {
  value = var.create_dynamic_group ? oci_identity_dynamic_group.this[0].id : null
}

output "policy_id" {
  value = var.create_policy ? oci_identity_policy.this[0].id : null
}
