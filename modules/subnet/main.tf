
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}


data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

resource "oci_core_subnet" "this" {
  for_each = var.subnets

  compartment_id             = var.compartment_id
  vcn_id                     = var.vcn_id
  cidr_block                 = each.value.cidr_block
  display_name               = each.value.display_name
  dns_label                  = lookup(each.value, "dns_label", null)
  availability_domain        = lookup(each.value, "availability_domain", null)
  prohibit_public_ip_on_vnic = lookup(each.value, "prohibit_public_ip_on_vnic", true)
  prohibit_internet_ingress  = lookup(each.value, "prohibit_internet_ingress", true)
  route_table_id             = lookup(each.value, "route_table_id", null)
  security_list_ids          = lookup(each.value, "security_list_ids", null)
  dhcp_options_id            = lookup(each.value, "dhcp_options_id", null)
  ipv6cidr_block             = lookup(each.value, "ipv6cidr_block", null)
  ipv6cidr_blocks            = lookup(each.value, "ipv6cidr_blocks", null)

  freeform_tags = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
  defined_tags  = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# DHCP Options (Optional)
# -----------------------------------------------------------------------------

resource "oci_core_dhcp_options" "this" {
  for_each = var.dhcp_options

  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = each.value.display_name

  options {
    type        = "DomainNameServer"
    server_type = lookup(each.value, "server_type", "VcnLocalPlusInternet")
    custom_dns_servers = lookup(each.value, "server_type", "VcnLocalPlusInternet") == "CustomDnsServer" ? lookup(each.value, "custom_dns_servers", []) : null
  }

  dynamic "options" {
    for_each = lookup(each.value, "search_domain_names", null) != null ? [1] : []
    content {
      type                = "SearchDomain"
      search_domain_names = each.value.search_domain_names
    }
  }

  freeform_tags = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
  defined_tags  = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "subnet_ids" {
  description = "Map of subnet names to their OCIDs"
  value       = { for k, v in oci_core_subnet.this : k => v.id }
}

output "subnet_cidr_blocks" {
  description = "Map of subnet names to their CIDR blocks"
  value       = { for k, v in oci_core_subnet.this : k => v.cidr_block }
}

output "subnet_dns_labels" {
  description = "Map of subnet names to their DNS labels"
  value       = { for k, v in oci_core_subnet.this : k => v.dns_label }
}

output "subnets" {
  description = "All subnet attributes"
  value       = oci_core_subnet.this
}

output "dhcp_options_ids" {
  description = "Map of DHCP options names to their OCIDs"
  value       = { for k, v in oci_core_dhcp_options.this : k => v.id }
}

output "availability_domains" {
  description = "Available ADs in the region"
  value       = data.oci_identity_availability_domains.ads.availability_domains[*].name
}
