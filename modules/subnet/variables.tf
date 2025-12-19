
variable "compartment_id" {
  description = "(Required) The OCID of the compartment to contain the subnet"
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

variable "subnets" {
  description = "(Required) Map of subnet configurations"
  type = map(object({
    cidr_block                 = string
    display_name               = string
    dns_label                  = optional(string)
    availability_domain        = optional(string)
    prohibit_public_ip_on_vnic = optional(bool, true)
    prohibit_internet_ingress  = optional(bool, true)
    route_table_id             = optional(string)
    security_list_ids          = optional(list(string))
    dhcp_options_id            = optional(string)
    ipv6cidr_block             = optional(string)
    ipv6cidr_blocks            = optional(list(string))
    freeform_tags              = optional(map(string), {})
    defined_tags               = optional(map(string), {})
  }))

  validation {
    condition     = length(var.subnets) > 0
    error_message = "At least one subnet must be defined."
  }
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "dhcp_options" {
  description = "(Optional) Map of DHCP options configurations"
  type = map(object({
    display_name        = string
    server_type         = optional(string, "VcnLocalPlusInternet")
    custom_dns_servers  = optional(list(string), [])
    search_domain_names = optional(list(string))
    freeform_tags       = optional(map(string), {})
    defined_tags        = optional(map(string), {})
  }))
  default = {}
}

# -----------------------------------------------------------------------------
# Tags
# -----------------------------------------------------------------------------

variable "freeform_tags" {
  description = "(Optional) Free-form tags for all subnets"
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "(Optional) Defined tags for all subnets"
  type        = map(string)
  default     = {}
}
