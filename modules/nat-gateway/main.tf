
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
# NAT Gateway Resource
# -----------------------------------------------------------------------------

resource "oci_core_nat_gateway" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.display_name
  block_traffic  = var.block_traffic
  public_ip_id   = var.public_ip_id
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
  description = "The OCID of the NAT Gateway"
  value       = oci_core_nat_gateway.this.id
}

output "nat_ip" {
  description = "The IP address of the NAT Gateway"
  value       = oci_core_nat_gateway.this.nat_ip
}

output "public_ip_id" {
  description = "The OCID of the public IP assigned to the NAT Gateway"
  value       = oci_core_nat_gateway.this.public_ip_id
}

output "display_name" {
  description = "The display name of the NAT Gateway"
  value       = oci_core_nat_gateway.this.display_name
}

output "state" {
  description = "The current state of the NAT Gateway"
  value       = oci_core_nat_gateway.this.state
}

output "time_created" {
  description = "The date and time the NAT Gateway was created"
  value       = oci_core_nat_gateway.this.time_created
}
