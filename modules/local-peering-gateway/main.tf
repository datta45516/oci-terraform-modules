
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
# Local Peering Gateway Resources
# -----------------------------------------------------------------------------

resource "oci_core_local_peering_gateway" "requestor" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.display_name
  peer_id        = var.peer_id
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
  description = "The OCID of the Local Peering Gateway"
  value       = oci_core_local_peering_gateway.requestor.id
}

output "display_name" {
  description = "The display name of the LPG"
  value       = oci_core_local_peering_gateway.requestor.display_name
}

output "is_cross_tenancy_peering" {
  description = "Whether the LPG is cross tenancy"
  value       = oci_core_local_peering_gateway.requestor.is_cross_tenancy_peering
}

output "peer_advertised_cidr" {
  description = "The smallest aggregate CIDR that contains all the CIDR routes advertised by the VCN at the other end"
  value       = oci_core_local_peering_gateway.requestor.peer_advertised_cidr
}

output "peer_advertised_cidr_details" {
  description = "The specific ranges of IP addresses available on or via the VCN at the other end"
  value       = oci_core_local_peering_gateway.requestor.peer_advertised_cidr_details
}

output "peering_status" {
  description = "The peering status"
  value       = oci_core_local_peering_gateway.requestor.peering_status
}

output "state" {
  description = "The LPG's current lifecycle state"
  value       = oci_core_local_peering_gateway.requestor.state
}

output "time_created" {
  description = "The date and time the LPG was created"
  value       = oci_core_local_peering_gateway.requestor.time_created
}
