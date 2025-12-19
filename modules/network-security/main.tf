
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
# Security Lists
# -----------------------------------------------------------------------------

resource "oci_core_security_list" "this" {
  for_each = var.security_lists

  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = each.value.display_name

  dynamic "egress_security_rules" {
    for_each = lookup(each.value, "egress_rules", [])
    content {
      destination      = egress_security_rules.value.destination
      protocol         = egress_security_rules.value.protocol
      description      = lookup(egress_security_rules.value, "description", null)
      destination_type = lookup(egress_security_rules.value, "destination_type", "CIDR_BLOCK")
      stateless        = lookup(egress_security_rules.value, "stateless", false)

      dynamic "tcp_options" {
        for_each = egress_security_rules.value.protocol == "6" && lookup(egress_security_rules.value, "tcp_options", null) != null ? [egress_security_rules.value.tcp_options] : []
        content {
          min = lookup(tcp_options.value, "destination_port_range_min", null)
          max = lookup(tcp_options.value, "destination_port_range_max", null)

          dynamic "source_port_range" {
            for_each = lookup(tcp_options.value, "source_port_range_min", null) != null ? [1] : []
            content {
              min = tcp_options.value.source_port_range_min
              max = tcp_options.value.source_port_range_max
            }
          }
        }
      }

      dynamic "udp_options" {
        for_each = egress_security_rules.value.protocol == "17" && lookup(egress_security_rules.value, "udp_options", null) != null ? [egress_security_rules.value.udp_options] : []
        content {
          min = lookup(udp_options.value, "destination_port_range_min", null)
          max = lookup(udp_options.value, "destination_port_range_max", null)

          dynamic "source_port_range" {
            for_each = lookup(udp_options.value, "source_port_range_min", null) != null ? [1] : []
            content {
              min = udp_options.value.source_port_range_min
              max = udp_options.value.source_port_range_max
            }
          }
        }
      }

      dynamic "icmp_options" {
        for_each = egress_security_rules.value.protocol == "1" && lookup(egress_security_rules.value, "icmp_options", null) != null ? [egress_security_rules.value.icmp_options] : []
        content {
          type = icmp_options.value.type
          code = lookup(icmp_options.value, "code", null)
        }
      }
    }
  }

  dynamic "ingress_security_rules" {
    for_each = lookup(each.value, "ingress_rules", [])
    content {
      source      = ingress_security_rules.value.source
      protocol    = ingress_security_rules.value.protocol
      description = lookup(ingress_security_rules.value, "description", null)
      source_type = lookup(ingress_security_rules.value, "source_type", "CIDR_BLOCK")
      stateless   = lookup(ingress_security_rules.value, "stateless", false)

      dynamic "tcp_options" {
        for_each = ingress_security_rules.value.protocol == "6" && lookup(ingress_security_rules.value, "tcp_options", null) != null ? [ingress_security_rules.value.tcp_options] : []
        content {
          min = lookup(tcp_options.value, "destination_port_range_min", null)
          max = lookup(tcp_options.value, "destination_port_range_max", null)

          dynamic "source_port_range" {
            for_each = lookup(tcp_options.value, "source_port_range_min", null) != null ? [1] : []
            content {
              min = tcp_options.value.source_port_range_min
              max = tcp_options.value.source_port_range_max
            }
          }
        }
      }

      dynamic "udp_options" {
        for_each = ingress_security_rules.value.protocol == "17" && lookup(ingress_security_rules.value, "udp_options", null) != null ? [ingress_security_rules.value.udp_options] : []
        content {
          min = lookup(udp_options.value, "destination_port_range_min", null)
          max = lookup(udp_options.value, "destination_port_range_max", null)

          dynamic "source_port_range" {
            for_each = lookup(udp_options.value, "source_port_range_min", null) != null ? [1] : []
            content {
              min = udp_options.value.source_port_range_min
              max = udp_options.value.source_port_range_max
            }
          }
        }
      }

      dynamic "icmp_options" {
        for_each = ingress_security_rules.value.protocol == "1" && lookup(ingress_security_rules.value, "icmp_options", null) != null ? [ingress_security_rules.value.icmp_options] : []
        content {
          type = icmp_options.value.type
          code = lookup(icmp_options.value, "code", null)
        }
      }
    }
  }

  freeform_tags = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
  defined_tags  = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# Network Security Groups
# -----------------------------------------------------------------------------

resource "oci_core_network_security_group" "this" {
  for_each = var.network_security_groups

  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = each.value.display_name

  freeform_tags = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
  defined_tags  = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
}

# -----------------------------------------------------------------------------
# NSG Security Rules
# -----------------------------------------------------------------------------

resource "oci_core_network_security_group_security_rule" "this" {
  for_each = var.nsg_rules

  network_security_group_id = lookup(each.value, "nsg_id", oci_core_network_security_group.this[each.value.nsg_key].id)
  direction                 = each.value.direction
  protocol                  = each.value.protocol
  description               = lookup(each.value, "description", null)
  stateless                 = lookup(each.value, "stateless", false)

  # Source (for INGRESS)
  source      = each.value.direction == "INGRESS" ? each.value.source : null
  source_type = each.value.direction == "INGRESS" ? lookup(each.value, "source_type", "CIDR_BLOCK") : null

  # Destination (for EGRESS)
  destination      = each.value.direction == "EGRESS" ? each.value.destination : null
  destination_type = each.value.direction == "EGRESS" ? lookup(each.value, "destination_type", "CIDR_BLOCK") : null

  dynamic "tcp_options" {
    for_each = each.value.protocol == "6" && lookup(each.value, "tcp_options", null) != null ? [each.value.tcp_options] : []
    content {
      dynamic "destination_port_range" {
        for_each = lookup(tcp_options.value, "destination_port_range_min", null) != null ? [1] : []
        content {
          min = tcp_options.value.destination_port_range_min
          max = tcp_options.value.destination_port_range_max
        }
      }

      dynamic "source_port_range" {
        for_each = lookup(tcp_options.value, "source_port_range_min", null) != null ? [1] : []
        content {
          min = tcp_options.value.source_port_range_min
          max = tcp_options.value.source_port_range_max
        }
      }
    }
  }

  dynamic "udp_options" {
    for_each = each.value.protocol == "17" && lookup(each.value, "udp_options", null) != null ? [each.value.udp_options] : []
    content {
      dynamic "destination_port_range" {
        for_each = lookup(udp_options.value, "destination_port_range_min", null) != null ? [1] : []
        content {
          min = udp_options.value.destination_port_range_min
          max = udp_options.value.destination_port_range_max
        }
      }

      dynamic "source_port_range" {
        for_each = lookup(udp_options.value, "source_port_range_min", null) != null ? [1] : []
        content {
          min = udp_options.value.source_port_range_min
          max = udp_options.value.source_port_range_max
        }
      }
    }
  }

  dynamic "icmp_options" {
    for_each = each.value.protocol == "1" && lookup(each.value, "icmp_options", null) != null ? [each.value.icmp_options] : []
    content {
      type = icmp_options.value.type
      code = lookup(icmp_options.value, "code", null)
    }
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "security_list_ids" {
  description = "Map of security list names to their OCIDs"
  value       = { for k, v in oci_core_security_list.this : k => v.id }
}

output "nsg_ids" {
  description = "Map of NSG names to their OCIDs"
  value       = { for k, v in oci_core_network_security_group.this : k => v.id }
}

output "security_lists" {
  description = "All security list attributes"
  value       = oci_core_security_list.this
}

output "network_security_groups" {
  description = "All NSG attributes"
  value       = oci_core_network_security_group.this
}

output "nsg_rules" {
  description = "All NSG security rules"
  value       = oci_core_network_security_group_security_rule.this
}
