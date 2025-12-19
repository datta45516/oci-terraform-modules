
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
# Remote Peering Connection Resource
# -----------------------------------------------------------------------------

resource "oci_core_remote_peering_connection" "this" {
  compartment_id   = var.compartment_id
  drg_id           = var.drg_id
  display_name     = var.display_name
  peer_id          = var.peer_id
  peer_region_name = var.peer_region_name

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
  description = "The OCID of the Remote Peering Connection"
  value       = oci_core_remote_peering_connection.this.id
}

output "display_name" {
  description = "The display name of the RPC"
  value       = oci_core_remote_peering_connection.this.display_name
}

output "is_cross_tenancy_peering" {
  description = "Whether the RPC is cross tenancy"
  value       = oci_core_remote_peering_connection.this.is_cross_tenancy_peering
}

output "peer_region_name" {
  description = "The region of the peer"
  value       = oci_core_remote_peering_connection.this.peer_region_name
}

output "peer_tenancy_id" {
  description = "The OCID of the peer tenancy"
  value       = oci_core_remote_peering_connection.this.peer_tenancy_id
}

output "peering_status" {
  description = "The peering status"
  value       = oci_core_remote_peering_connection.this.peering_status
}

output "state" {
  description = "The RPC's current lifecycle state"
  value       = oci_core_remote_peering_connection.this.state
}

output "time_created" {
  description = "The date and time the RPC was created"
  value       = oci_core_remote_peering_connection.this.time_created
}
