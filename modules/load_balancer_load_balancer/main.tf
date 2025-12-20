terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_load_balancer_load_balancer" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  shape          = var.shape
  subnet_ids     = var.subnet_ids
  is_private     = var.is_private

  dynamic "shape_details" {
    for_each = var.shape == "flexible" ? [1] : []
    content {
      minimum_bandwidth_in_mbps = var.minimum_bandwidth_in_mbps
      maximum_bandwidth_in_mbps = var.maximum_bandwidth_in_mbps
    }
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_load_balancer_load_balancer.this.id }
output "ip_addresses" { value = oci_load_balancer_load_balancer.this.ip_addresses }
