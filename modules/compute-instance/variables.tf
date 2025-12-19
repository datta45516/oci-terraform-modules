
variable "compartment_id" {
  description = "(Required) The OCID of the compartment"
  type        = string
}

variable "instances" {
  description = "(Required) Map of instance configurations"
  type = map(object({
    display_name                       = string
    availability_domain                = optional(string)
    shape                              = optional(string)
    shape_config                       = optional(object({
      ocpus                     = number
      memory_in_gbs             = optional(number)
      baseline_ocpu_utilization = optional(string)
    }))
    subnet_id                          = optional(string)
    source_type                        = optional(string)
    source_id                          = optional(string)
    boot_volume_size_in_gbs            = optional(number)
    boot_volume_vpus_per_gb            = optional(number)
    kms_key_id                         = optional(string)
    assign_public_ip                   = optional(bool)
    assign_private_dns_record          = optional(bool)
    private_ip                         = optional(string)
    vnic_display_name                  = optional(string)
    hostname_label                     = optional(string)
    nsg_ids                            = optional(list(string))
    skip_source_dest_check             = optional(bool)
    ssh_public_key                     = optional(string)
    user_data                          = optional(string)
    metadata                           = optional(map(string))
    extended_metadata                  = optional(map(any))
    is_management_disabled             = optional(bool)
    is_monitoring_disabled             = optional(bool)
    plugins_config                     = optional(list(object({
      name          = string
      desired_state = string
    })))
    is_live_migration_preferred        = optional(bool)
    recovery_action                    = optional(string)
    are_legacy_imds_endpoints_disabled = optional(bool)
    launch_options                     = optional(object({
      boot_volume_type                    = optional(string)
      firmware                            = optional(string)
      is_consistent_volume_naming_enabled = optional(bool)
      is_pv_encryption_in_transit_enabled = optional(bool)
      network_type                        = optional(string)
      remote_data_volume_type             = optional(string)
    }))
    platform_config                    = optional(object({
      type                                           = string
      are_virtual_instructions_enabled               = optional(bool)
      is_access_control_service_enabled              = optional(bool)
      is_input_output_memory_management_unit_enabled = optional(bool)
      is_measured_boot_enabled                       = optional(bool)
      is_memory_encryption_enabled                   = optional(bool)
      is_secure_boot_enabled                         = optional(bool)
      is_symmetric_multi_threading_enabled           = optional(bool)
      is_trusted_platform_module_enabled             = optional(bool)
      numa_nodes_per_socket                          = optional(string)
      percentage_of_cores_enabled                    = optional(number)
    }))
    is_preemptible                     = optional(bool)
    preemption_action_type             = optional(string)
    preserve_boot_volume               = optional(bool)
    capacity_reservation_id            = optional(string)
    dedicated_vm_host_id               = optional(string)
    fault_domain                       = optional(string)
    state                              = optional(string)
    preserve_boot_volume_on_destroy    = optional(bool)
    freeform_tags                      = optional(map(string))
    defined_tags                       = optional(map(string))
  }))
}

# -----------------------------------------------------------------------------
# Default Instance Configuration
# -----------------------------------------------------------------------------

variable "shape" {
  description = "(Optional) Default shape for instances"
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "shape_config" {
  description = "(Optional) Default shape configuration for Flex shapes"
  type = object({
    ocpus                     = number
    memory_in_gbs             = optional(number)
    baseline_ocpu_utilization = optional(string)
  })
  default = {
    ocpus         = 1
    memory_in_gbs = 16
  }
}

variable "subnet_id" {
  description = "(Optional) Default subnet OCID"
  type        = string
  default     = null
}

variable "source_type" {
  description = "(Optional) Source type for instances"
  type        = string
  default     = "image"
}

variable "image_id" {
  description = "(Optional) The OCID of the image to use"
  type        = string
  default     = null
}

variable "operating_system" {
  description = "(Optional) The OS to use when looking up an image"
  type        = string
  default     = "Oracle Linux"
}

variable "operating_system_version" {
  description = "(Optional) The OS version to use when looking up an image"
  type        = string
  default     = "8"
}

variable "boot_volume_size_in_gbs" {
  description = "(Optional) Boot volume size in GBs"
  type        = number
  default     = 50
}

variable "boot_volume_vpus_per_gb" {
  description = "(Optional) VPUs per GB for boot volume (10-120)"
  type        = number
  default     = 10

  validation {
    condition     = var.boot_volume_vpus_per_gb >= 10 && var.boot_volume_vpus_per_gb <= 120
    error_message = "Boot volume VPUs per GB must be between 10 and 120."
  }
}

variable "kms_key_id" {
  description = "(Optional) OCID of the KMS key for boot volume encryption"
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# VNIC Configuration
# -----------------------------------------------------------------------------

variable "assign_public_ip" {
  description = "(Optional) Whether to assign a public IP"
  type        = bool
  default     = false
}

variable "assign_private_dns_record" {
  description = "(Optional) Whether to assign a private DNS record"
  type        = bool
  default     = true
}

variable "nsg_ids" {
  description = "(Optional) List of NSG OCIDs"
  type        = list(string)
  default     = []
}

variable "skip_source_dest_check" {
  description = "(Optional) Whether to skip source/dest check"
  type        = bool
  default     = false
}

# -----------------------------------------------------------------------------
# Metadata
# -----------------------------------------------------------------------------

variable "ssh_public_key" {
  description = "(Optional) SSH public key for the instance"
  type        = string
  default     = null
}

variable "user_data" {
  description = "(Optional) User data script"
  type        = string
  default     = null
}

variable "metadata" {
  description = "(Optional) Additional metadata"
  type        = map(string)
  default     = {}
}

variable "extended_metadata" {
  description = "(Optional) Extended metadata"
  type        = map(any)
  default     = {}
}

# -----------------------------------------------------------------------------
# Agent Configuration
# -----------------------------------------------------------------------------

variable "is_management_disabled" {
  description = "(Optional) Whether management agent is disabled"
  type        = bool
  default     = false
}

variable "is_monitoring_disabled" {
  description = "(Optional) Whether monitoring agent is disabled"
  type        = bool
  default     = false
}

variable "plugins_config" {
  description = "(Optional) Agent plugins configuration"
  type = list(object({
    name          = string
    desired_state = string
  }))
  default = [
    {
      name          = "Vulnerability Scanning"
      desired_state = "ENABLED"
    },
    {
      name          = "Compute Instance Monitoring"
      desired_state = "ENABLED"
    },
    {
      name          = "Bastion"
      desired_state = "ENABLED"
    }
  ]
}

# -----------------------------------------------------------------------------
# Availability Configuration
# -----------------------------------------------------------------------------

variable "is_live_migration_preferred" {
  description = "(Optional) Whether live migration is preferred"
  type        = bool
  default     = true
}

variable "recovery_action" {
  description = "(Optional) Recovery action (RESTORE_INSTANCE or STOP_INSTANCE)"
  type        = string
  default     = "RESTORE_INSTANCE"
}

# -----------------------------------------------------------------------------
# Instance Options
# -----------------------------------------------------------------------------

variable "are_legacy_imds_endpoints_disabled" {
  description = "(Optional) Whether legacy IMDS endpoints are disabled"
  type        = bool
  default     = true
}

variable "launch_options" {
  description = "(Optional) Launch options"
  type = object({
    boot_volume_type                    = optional(string)
    firmware                            = optional(string)
    is_consistent_volume_naming_enabled = optional(bool)
    is_pv_encryption_in_transit_enabled = optional(bool)
    network_type                        = optional(string)
    remote_data_volume_type             = optional(string)
  })
  default = null
}

variable "platform_config" {
  description = "(Optional) Platform configuration"
  type = object({
    type                                           = string
    are_virtual_instructions_enabled               = optional(bool)
    is_access_control_service_enabled              = optional(bool)
    is_input_output_memory_management_unit_enabled = optional(bool)
    is_measured_boot_enabled                       = optional(bool)
    is_memory_encryption_enabled                   = optional(bool)
    is_secure_boot_enabled                         = optional(bool)
    is_symmetric_multi_threading_enabled           = optional(bool)
    is_trusted_platform_module_enabled             = optional(bool)
    numa_nodes_per_socket                          = optional(string)
    percentage_of_cores_enabled                    = optional(number)
  })
  default = null
}

# -----------------------------------------------------------------------------
# Preemptible Instance
# -----------------------------------------------------------------------------

variable "is_preemptible" {
  description = "(Optional) Whether instance is preemptible"
  type        = bool
  default     = false
}

variable "preemption_action_type" {
  description = "(Optional) Preemption action type"
  type        = string
  default     = "TERMINATE"
}

variable "preserve_boot_volume" {
  description = "(Optional) Whether to preserve boot volume on preemption"
  type        = bool
  default     = false
}

# -----------------------------------------------------------------------------
# Placement
# -----------------------------------------------------------------------------

variable "capacity_reservation_id" {
  description = "(Optional) Capacity reservation OCID"
  type        = string
  default     = null
}

variable "dedicated_vm_host_id" {
  description = "(Optional) Dedicated VM host OCID"
  type        = string
  default     = null
}

variable "fault_domain" {
  description = "(Optional) Fault domain"
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# State
# -----------------------------------------------------------------------------

variable "instance_state" {
  description = "(Optional) Instance state (RUNNING or STOPPED)"
  type        = string
  default     = "RUNNING"
}

variable "preserve_boot_volume_on_destroy" {
  description = "(Optional) Whether to preserve boot volume on destroy"
  type        = bool
  default     = false
}

# -----------------------------------------------------------------------------
# Secondary VNICs
# -----------------------------------------------------------------------------

variable "secondary_vnics" {
  description = "(Optional) Secondary VNICs to attach"
  type = map(object({
    instance_key              = string
    display_name              = string
    subnet_id                 = string
    nic_index                 = optional(number, 0)
    assign_public_ip          = optional(bool, false)
    assign_private_dns_record = optional(bool, true)
    private_ip                = optional(string)
    hostname_label            = optional(string)
    nsg_ids                   = optional(list(string), [])
    skip_source_dest_check    = optional(bool, false)
    freeform_tags             = optional(map(string), {})
    defined_tags              = optional(map(string), {})
  }))
  default = {}
}

# -----------------------------------------------------------------------------
# Timeouts
# -----------------------------------------------------------------------------

variable "instance_timeout_create" {
  description = "(Optional) Timeout for instance creation"
  type        = string
  default     = "45m"
}

variable "instance_timeout_update" {
  description = "(Optional) Timeout for instance update"
  type        = string
  default     = "45m"
}

variable "instance_timeout_delete" {
  description = "(Optional) Timeout for instance deletion"
  type        = string
  default     = "45m"
}

# -----------------------------------------------------------------------------
# Tags
# -----------------------------------------------------------------------------

variable "freeform_tags" {
  description = "(Optional) Free-form tags"
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "(Optional) Defined tags"
  type        = map(string)
  default     = {}
}
