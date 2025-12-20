terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_network_load_balancer_network_load_balancer" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  subnet_id      = var.subnet_id
  is_private     = var.is_private

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_network_load_balancer_network_load_balancer.this.id }
output "ip_addresses" { value = oci_network_load_balancer_network_load_balancer.this.ip_addresses }
