terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_containerengine_cluster" "this" {
  compartment_id     = var.compartment_id
  name               = var.name
  kubernetes_version = var.kubernetes_version
  vcn_id             = var.vcn_id

  endpoint_config {
    is_public_ip_enabled = var.endpoint_is_public
    subnet_id            = var.endpoint_subnet_id
  }

  options {
    service_lb_subnet_ids = var.service_lb_subnet_ids
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_containerengine_cluster.this.id }
output "endpoints" { value = oci_containerengine_cluster.this.endpoints }
