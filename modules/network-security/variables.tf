
variable "compartment_id" {
  description = "(Required) The OCID of the compartment"
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.(compartment|tenancy)\\.oc[0-9]+\\.[a-z]+\\.[a-z0-9]+$", var.compartment_id))
    error_message = "The compartment_id must be a valid OCID."
  }
}

variable "vcn_id" {
  description = "(Required) The OCID of the VCN"
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.vcn\\.oc[0-9]+\\.[a-z]+\\.[a-z0-9]+$", var.vcn_id))
    error_message = "The vcn_id must be a valid VCN OCID."
  }
}

# -----------------------------------------------------------------------------
# Security Lists
# -----------------------------------------------------------------------------

variable "security_lists" {
  description = "(Optional) Map of security lists to create"
  type = map(object({
    display_name = string
    egress_rules = optional(list(object({
      destination      = string
      protocol         = string
      description      = optional(string)
      destination_type = optional(string, "CIDR_BLOCK")
      stateless        = optional(bool, false)
      tcp_options = optional(object({
        destination_port_range_min = optional(number)
        destination_port_range_max = optional(number)
        source_port_range_min      = optional(number)
        source_port_range_max      = optional(number)
      }))
      udp_options = optional(object({
        destination_port_range_min = optional(number)
        destination_port_range_max = optional(number)
        source_port_range_min      = optional(number)
        source_port_range_max      = optional(number)
      }))
      icmp_options = optional(object({
        type = number
        code = optional(number)
      }))
    })), [])
    ingress_rules = optional(list(object({
      source      = string
      protocol    = string
      description = optional(string)
      source_type = optional(string, "CIDR_BLOCK")
      stateless   = optional(bool, false)
      tcp_options = optional(object({
        destination_port_range_min = optional(number)
        destination_port_range_max = optional(number)
        source_port_range_min      = optional(number)
        source_port_range_max      = optional(number)
      }))
      udp_options = optional(object({
        destination_port_range_min = optional(number)
        destination_port_range_max = optional(number)
        source_port_range_min      = optional(number)
        source_port_range_max      = optional(number)
      }))
      icmp_options = optional(object({
        type = number
        code = optional(number)
      }))
    })), [])
    freeform_tags = optional(map(string), {})
    defined_tags  = optional(map(string), {})
  }))
  default = {}
}

# -----------------------------------------------------------------------------
# Network Security Groups
# -----------------------------------------------------------------------------

variable "network_security_groups" {
  description = "(Optional) Map of NSGs to create"
  type = map(object({
    display_name  = string
    freeform_tags = optional(map(string), {})
    defined_tags  = optional(map(string), {})
  }))
  default = {}
}

variable "nsg_rules" {
  description = "(Optional) Map of NSG security rules"
  type = map(object({
    nsg_key          = optional(string)
    nsg_id           = optional(string)
    direction        = string
    protocol         = string
    description      = optional(string)
    stateless        = optional(bool, false)
    source           = optional(string)
    source_type      = optional(string, "CIDR_BLOCK")
    destination      = optional(string)
    destination_type = optional(string, "CIDR_BLOCK")
    tcp_options = optional(object({
      destination_port_range_min = optional(number)
      destination_port_range_max = optional(number)
      source_port_range_min      = optional(number)
      source_port_range_max      = optional(number)
    }))
    udp_options = optional(object({
      destination_port_range_min = optional(number)
      destination_port_range_max = optional(number)
      source_port_range_min      = optional(number)
      source_port_range_max      = optional(number)
    }))
    icmp_options = optional(object({
      type = number
      code = optional(number)
    }))
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.nsg_rules : contains(["INGRESS", "EGRESS"], v.direction)
    ])
    error_message = "Direction must be either INGRESS or EGRESS."
  }
}

# -----------------------------------------------------------------------------
# Tags
# -----------------------------------------------------------------------------

variable "freeform_tags" {
  description = "(Optional) Free-form tags for all resources"
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "(Optional) Defined tags for all resources"
  type        = map(string)
  default     = {}
}
