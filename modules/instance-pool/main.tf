terraform {
  required_version = ">= 1.0.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

resource "oci_core_instance_pool" "this" {
  compartment_id            = var.compartment_id
  instance_configuration_id = var.instance_configuration_id
  display_name              = var.display_name
  size                      = var.size
  state                     = var.state

  dynamic "placement_configurations" {
    for_each = var.placement_configurations
    content {
      availability_domain = placement_configurations.value.availability_domain
      fault_domains       = lookup(placement_configurations.value, "fault_domains", null)
      primary_subnet_id   = placement_configurations.value.primary_subnet_id

      dynamic "secondary_vnic_subnets" {
        for_each = lookup(placement_configurations.value, "secondary_vnic_subnets", [])
        content {
          display_name = secondary_vnic_subnets.value.display_name
          subnet_id    = secondary_vnic_subnets.value.subnet_id
        }
      }
    }
  }

  dynamic "load_balancers" {
    for_each = var.load_balancers
    content {
      backend_set_name = load_balancers.value.backend_set_name
      load_balancer_id = load_balancers.value.load_balancer_id
      port             = load_balancers.value.port
      vnic_selection   = load_balancers.value.vnic_selection
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

output "id" {
  description = "The OCID of the instance pool"
  value       = oci_core_instance_pool.this.id
}

output "actual_size" {
  description = "The actual size of the instance pool"
  value       = oci_core_instance_pool.this.actual_size
}

output "state" {
  description = "The current state of the instance pool"
  value       = oci_core_instance_pool.this.state
}

output "time_created" {
  description = "The date and time the instance pool was created"
  value       = oci_core_instance_pool.this.time_created
}
