terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_containerengine_node_pool" "this" {
  compartment_id     = var.compartment_id
  cluster_id         = var.cluster_id
  name               = var.name
  kubernetes_version = var.kubernetes_version
  node_shape         = var.node_shape

  node_config_details {
    size = var.size

    dynamic "placement_configs" {
      for_each = var.placement_configs
      content {
        availability_domain = placement_configs.value.availability_domain
        subnet_id           = placement_configs.value.subnet_id
      }
    }
  }

  node_source_details {
    source_type = var.source_type
    image_id    = var.image_id
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_containerengine_node_pool.this.id }
output "nodes" { value = oci_containerengine_node_pool.this.nodes }
