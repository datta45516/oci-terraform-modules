terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_containerengine_cluster" "this" {
  compartment_id     = var.compartment_id
  name               = var.cluster_name
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

resource "oci_containerengine_node_pool" "this" {
  cluster_id         = oci_containerengine_cluster.this.id
  compartment_id     = var.compartment_id
  name               = var.node_pool_name
  kubernetes_version = var.kubernetes_version
  node_shape         = var.node_shape

  node_config_details {
    size = var.node_pool_size

    dynamic "placement_configs" {
      for_each = var.placement_configs
      content {
        availability_domain = placement_configs.value.availability_domain
        subnet_id           = placement_configs.value.subnet_id
      }
    }
  }

  node_source_details {
    source_type = var.node_source_type
    image_id    = var.node_image_id
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "cluster_id" { value = oci_containerengine_cluster.this.id }
output "node_pool_id" { value = oci_containerengine_node_pool.this.id }
