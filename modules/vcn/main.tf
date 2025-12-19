
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

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "oci_core_services" "all_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

# -----------------------------------------------------------------------------
# VCN Resource
# -----------------------------------------------------------------------------

resource "oci_core_vcn" "this" {
  compartment_id = var.compartment_id
  display_name   = var.vcn_name
  dns_label      = var.vcn_dns_label
  cidr_blocks    = var.vcn_cidrs
  is_ipv6enabled = var.is_ipv6enabled

  byoipv6cidr_details {
    byoipv6range_id = var.byoipv6range_id
    ipv6cidr_block  = var.ipv6cidr_block
  } 

  dynamic "byoipv6cidr_details" {
    for_each = var.byoipv6cidr_details
    content {
      byoipv6range_id = byoipv6cidr_details.value.byoipv6range_id
      ipv6cidr_block  = byoipv6cidr_details.value.ipv6cidr_block
    }
  }

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# Default Security List (Optional - for lockdown)
# -----------------------------------------------------------------------------

resource "oci_core_default_security_list" "lockdown" {
  count = var.lockdown_default_seclist ? 1 : 0

  manage_default_resource_id = oci_core_vcn.this.default_security_list_id
  display_name               = "${var.vcn_name}-default-security-list-lockdown"

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# Internet Gateway (Optional)
# -----------------------------------------------------------------------------

resource "oci_core_internet_gateway" "this" {
  count = var.create_internet_gateway ? 1 : 0

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
  display_name   = var.internet_gateway_display_name != null ? var.internet_gateway_display_name : "${var.vcn_name}-igw"
  enabled        = var.internet_gateway_enabled
  route_table_id = var.internet_gateway_route_table_id

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# NAT Gateway (Optional)
# -----------------------------------------------------------------------------

resource "oci_core_nat_gateway" "this" {
  count = var.create_nat_gateway ? 1 : 0

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
  display_name   = var.nat_gateway_display_name != null ? var.nat_gateway_display_name : "${var.vcn_name}-natgw"
  block_traffic  = var.nat_gateway_block_traffic
  public_ip_id   = var.nat_gateway_public_ip_id
  route_table_id = var.nat_gateway_route_table_id

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# Service Gateway (Optional)
# -----------------------------------------------------------------------------

resource "oci_core_service_gateway" "this" {
  count = var.create_service_gateway ? 1 : 0

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
  display_name   = var.service_gateway_display_name != null ? var.service_gateway_display_name : "${var.vcn_name}-sgw"
  route_table_id = var.service_gateway_route_table_id

  services {
    service_id = data.oci_core_services.all_services.services[0].id
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

output "vcn_id" {
  description = "The OCID of the VCN"
  value       = oci_core_vcn.this.id
}

output "vcn_cidr_blocks" {
  description = "The list of IPv4 CIDR blocks the VCN will use"
  value       = oci_core_vcn.this.cidr_blocks
}

output "vcn_dns_label" {
  description = "The DNS label of the VCN"
  value       = oci_core_vcn.this.dns_label
}

output "vcn_domain_name" {
  description = "The VCN's domain name"
  value       = oci_core_vcn.this.vcn_domain_name
}

output "vcn_default_security_list_id" {
  description = "The OCID of the VCN's default security list"
  value       = oci_core_vcn.this.default_security_list_id
}

output "vcn_default_route_table_id" {
  description = "The OCID of the VCN's default route table"
  value       = oci_core_vcn.this.default_route_table_id
}

output "vcn_default_dhcp_options_id" {
  description = "The OCID of the VCN's default DHCP options"
  value       = oci_core_vcn.this.default_dhcp_options_id
}

output "internet_gateway_id" {
  description = "The OCID of the Internet Gateway"
  value       = var.create_internet_gateway ? oci_core_internet_gateway.this[0].id : null
}

output "nat_gateway_id" {
  description = "The OCID of the NAT Gateway"
  value       = var.create_nat_gateway ? oci_core_nat_gateway.this[0].id : null
}

output "nat_gateway_ip" {
  description = "The IP address of the NAT Gateway"
  value       = var.create_nat_gateway ? oci_core_nat_gateway.this[0].nat_ip : null
}

output "service_gateway_id" {
  description = "The OCID of the Service Gateway"
  value       = var.create_service_gateway ? oci_core_service_gateway.this[0].id : null
}

output "all_services" {
  description = "All OCI services available"
  value       = data.oci_core_services.all_services.services
}

output "availability_domains" {
  description = "Availability domains in the region"
  value       = data.oci_identity_availability_domains.ads.availability_domains
}
