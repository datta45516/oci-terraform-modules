
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

resource "oci_core_instance_configuration" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name

  instance_details {
    instance_type = var.instance_type

    dynamic "launch_details" {
      for_each = var.instance_type == "compute" ? [1] : []
      content {
        compartment_id      = var.compartment_id
        display_name        = var.launch_display_name
        shape               = var.shape
        availability_domain = var.availability_domain

        dynamic "shape_config" {
          for_each = var.shape_config != null ? [var.shape_config] : []
          content {
            ocpus         = shape_config.value.ocpus
            memory_in_gbs = lookup(shape_config.value, "memory_in_gbs", null)
          }
        }

        create_vnic_details {
          subnet_id        = var.subnet_id
          assign_public_ip = var.assign_public_ip
          nsg_ids          = var.nsg_ids
        }

        source_details {
          source_type             = var.source_type
          image_id                = var.image_id
          boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
        }

        metadata = {
          ssh_authorized_keys = var.ssh_public_key
          user_data           = var.user_data != null ? base64encode(var.user_data) : null
        }
      }
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
  description = "The OCID of the instance configuration"
  value       = oci_core_instance_configuration.this.id
}

output "time_created" {
  description = "The date and time the instance configuration was created"
  value       = oci_core_instance_configuration.this.time_created
}
