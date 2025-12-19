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

data "oci_core_images" "this" {
  count = var.source_type == "image" && var.image_id == null ? 1 : 0

  compartment_id           = var.compartment_id
  operating_system         = var.operating_system
  operating_system_version = var.operating_system_version
  shape                    = var.shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
  state                    = "AVAILABLE"
}

# -----------------------------------------------------------------------------
# Compute Instance Resource
# -----------------------------------------------------------------------------

resource "oci_core_instance" "this" {
  for_each = var.instances

  compartment_id      = var.compartment_id
  availability_domain = lookup(each.value, "availability_domain", data.oci_identity_availability_domains.ads.availability_domains[0].name)
  display_name        = each.value.display_name
  shape               = lookup(each.value, "shape", var.shape)

  # Shape Configuration (for Flex shapes)
  dynamic "shape_config" {
    for_each = lookup(each.value, "shape_config", var.shape_config) != null ? [lookup(each.value, "shape_config", var.shape_config)] : []
    content {
      ocpus                     = shape_config.value.ocpus
      memory_in_gbs             = lookup(shape_config.value, "memory_in_gbs", shape_config.value.ocpus * 16)
      baseline_ocpu_utilization = lookup(shape_config.value, "baseline_ocpu_utilization", null)
    }
  }

  # Source Details
  source_details {
    source_type             = lookup(each.value, "source_type", var.source_type)
    source_id               = lookup(each.value, "source_id", var.image_id != null ? var.image_id : data.oci_core_images.this[0].images[0].id)
    boot_volume_size_in_gbs = lookup(each.value, "boot_volume_size_in_gbs", var.boot_volume_size_in_gbs)
    boot_volume_vpus_per_gb = lookup(each.value, "boot_volume_vpus_per_gb", var.boot_volume_vpus_per_gb)
    kms_key_id              = lookup(each.value, "kms_key_id", var.kms_key_id)
  }

  # Create VNIC Details
  create_vnic_details {
    subnet_id                 = lookup(each.value, "subnet_id", var.subnet_id)
    assign_public_ip          = lookup(each.value, "assign_public_ip", var.assign_public_ip)
    assign_private_dns_record = lookup(each.value, "assign_private_dns_record", var.assign_private_dns_record)
    private_ip                = lookup(each.value, "private_ip", null)
    display_name              = lookup(each.value, "vnic_display_name", "${each.value.display_name}-vnic")
    hostname_label            = lookup(each.value, "hostname_label", null)
    nsg_ids                   = lookup(each.value, "nsg_ids", var.nsg_ids)
    skip_source_dest_check    = lookup(each.value, "skip_source_dest_check", var.skip_source_dest_check)
    freeform_tags             = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
    defined_tags              = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))
  }

  # Metadata
  metadata = merge(
    {
      ssh_authorized_keys = lookup(each.value, "ssh_public_key", var.ssh_public_key)
    },
    lookup(each.value, "user_data", var.user_data) != null ? {
      user_data = base64encode(lookup(each.value, "user_data", var.user_data))
    } : {},
    lookup(each.value, "metadata", var.metadata)
  )

  # Extended Metadata
  extended_metadata = lookup(each.value, "extended_metadata", var.extended_metadata)

  # Agent Config
  agent_config {
    is_management_disabled = lookup(each.value, "is_management_disabled", var.is_management_disabled)
    is_monitoring_disabled = lookup(each.value, "is_monitoring_disabled", var.is_monitoring_disabled)

    dynamic "plugins_config" {
      for_each = lookup(each.value, "plugins_config", var.plugins_config)
      content {
        name          = plugins_config.value.name
        desired_state = plugins_config.value.desired_state
      }
    }
  }

  # Availability Config
  availability_config {
    is_live_migration_preferred = lookup(each.value, "is_live_migration_preferred", var.is_live_migration_preferred)
    recovery_action             = lookup(each.value, "recovery_action", var.recovery_action)
  }

  # Instance Options
  instance_options {
    are_legacy_imds_endpoints_disabled = lookup(each.value, "are_legacy_imds_endpoints_disabled", var.are_legacy_imds_endpoints_disabled)
  }

  # Launch Options
  dynamic "launch_options" {
    for_each = lookup(each.value, "launch_options", var.launch_options) != null ? [lookup(each.value, "launch_options", var.launch_options)] : []
    content {
      boot_volume_type                    = lookup(launch_options.value, "boot_volume_type", null)
      firmware                            = lookup(launch_options.value, "firmware", null)
      is_consistent_volume_naming_enabled = lookup(launch_options.value, "is_consistent_volume_naming_enabled", null)
      is_pv_encryption_in_transit_enabled = lookup(launch_options.value, "is_pv_encryption_in_transit_enabled", null)
      network_type                        = lookup(launch_options.value, "network_type", null)
      remote_data_volume_type             = lookup(launch_options.value, "remote_data_volume_type", null)
    }
  }

  # Platform Config
  dynamic "platform_config" {
    for_each = lookup(each.value, "platform_config", var.platform_config) != null ? [lookup(each.value, "platform_config", var.platform_config)] : []
    content {
      type                                           = platform_config.value.type
      are_virtual_instructions_enabled               = lookup(platform_config.value, "are_virtual_instructions_enabled", null)
      is_access_control_service_enabled              = lookup(platform_config.value, "is_access_control_service_enabled", null)
      is_input_output_memory_management_unit_enabled = lookup(platform_config.value, "is_input_output_memory_management_unit_enabled", null)
      is_measured_boot_enabled                       = lookup(platform_config.value, "is_measured_boot_enabled", null)
      is_memory_encryption_enabled                   = lookup(platform_config.value, "is_memory_encryption_enabled", null)
      is_secure_boot_enabled                         = lookup(platform_config.value, "is_secure_boot_enabled", null)
      is_symmetric_multi_threading_enabled           = lookup(platform_config.value, "is_symmetric_multi_threading_enabled", null)
      is_trusted_platform_module_enabled             = lookup(platform_config.value, "is_trusted_platform_module_enabled", null)
      numa_nodes_per_socket                          = lookup(platform_config.value, "numa_nodes_per_socket", null)
      percentage_of_cores_enabled                    = lookup(platform_config.value, "percentage_of_cores_enabled", null)
    }
  }

  # Preemptible Instance Config
  dynamic "preemptible_instance_config" {
    for_each = lookup(each.value, "is_preemptible", var.is_preemptible) ? [1] : []
    content {
      preemption_action {
        type                 = lookup(each.value, "preemption_action_type", var.preemption_action_type)
        preserve_boot_volume = lookup(each.value, "preserve_boot_volume", var.preserve_boot_volume)
      }
    }
  }

  # Capacity Reservation
  capacity_reservation_id = lookup(each.value, "capacity_reservation_id", var.capacity_reservation_id)

  # Dedicated VM Host
  dedicated_vm_host_id = lookup(each.value, "dedicated_vm_host_id", var.dedicated_vm_host_id)

  # Fault Domain
  fault_domain = lookup(each.value, "fault_domain", var.fault_domain)

  # State
  state = lookup(each.value, "state", var.instance_state)

  # Preserve Boot Volume
  preserve_boot_volume = lookup(each.value, "preserve_boot_volume_on_destroy", var.preserve_boot_volume_on_destroy)

  freeform_tags = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
  defined_tags  = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))

  lifecycle {
    ignore_changes = [
      defined_tags["Oracle-Tags.CreatedBy"],
      defined_tags["Oracle-Tags.CreatedOn"],
      source_details[0].source_id
    ]
  }

  timeouts {
    create = var.instance_timeout_create
    update = var.instance_timeout_update
    delete = var.instance_timeout_delete
  }
}

# -----------------------------------------------------------------------------
# Secondary VNICs (Optional)
# -----------------------------------------------------------------------------

resource "oci_core_vnic_attachment" "secondary_vnics" {
  for_each = var.secondary_vnics

  instance_id  = oci_core_instance.this[each.value.instance_key].id
  display_name = each.value.display_name
  nic_index    = lookup(each.value, "nic_index", 0)

  create_vnic_details {
    subnet_id                 = each.value.subnet_id
    assign_public_ip          = lookup(each.value, "assign_public_ip", false)
    assign_private_dns_record = lookup(each.value, "assign_private_dns_record", true)
    private_ip                = lookup(each.value, "private_ip", null)
    display_name              = each.value.display_name
    hostname_label            = lookup(each.value, "hostname_label", null)
    nsg_ids                   = lookup(each.value, "nsg_ids", [])
    skip_source_dest_check    = lookup(each.value, "skip_source_dest_check", false)
    freeform_tags             = merge(var.freeform_tags, lookup(each.value, "freeform_tags", {}))
    defined_tags              = merge(var.defined_tags, lookup(each.value, "defined_tags", {}))
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "instance_ids" {
  description = "Map of instance names to their OCIDs"
  value       = { for k, v in oci_core_instance.this : k => v.id }
}

output "instance_private_ips" {
  description = "Map of instance names to their private IPs"
  value       = { for k, v in oci_core_instance.this : k => v.private_ip }
}

output "instance_public_ips" {
  description = "Map of instance names to their public IPs"
  value       = { for k, v in oci_core_instance.this : k => v.public_ip }
}

output "instances" {
  description = "All instance attributes"
  value       = oci_core_instance.this
}

output "boot_volume_ids" {
  description = "Map of instance names to their boot volume OCIDs"
  value       = { for k, v in oci_core_instance.this : k => v.boot_volume_id }
}

output "availability_domains" {
  description = "Available ADs in the region"
  value       = data.oci_identity_availability_domains.ads.availability_domains[*].name
}

output "secondary_vnic_ids" {
  description = "Map of secondary VNIC names to their OCIDs"
  value       = { for k, v in oci_core_vnic_attachment.secondary_vnics : k => v.vnic_id }
}
