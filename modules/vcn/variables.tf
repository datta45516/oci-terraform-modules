
variable "compartment_id" {
  description = "(Required) The OCID of the compartment to contain the VCN"
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.compartment\\.oc[0-9]+\\.[a-z]+\\.[a-z0-9]+$", var.compartment_id)) || can(regex("^ocid1\\.tenancy\\.oc[0-9]+\\.[a-z]+\\.[a-z0-9]+$", var.compartment_id))
    error_message = "The compartment_id must be a valid OCID."
  }
}

variable "vcn_name" {
  description = "(Required) User-friendly name for the VCN"
  type        = string

  validation {
    condition     = length(var.vcn_name) >= 1 && length(var.vcn_name) <= 255
    error_message = "VCN name must be between 1 and 255 characters."
  }
}

variable "vcn_cidrs" {
  description = "(Required) The list of one or more IPv4 CIDR blocks for the VCN"
  type        = list(string)

  validation {
    condition     = length(var.vcn_cidrs) > 0
    error_message = "At least one CIDR block must be provided."
  }
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "vcn_dns_label" {
  description = "(Optional) A DNS label for the VCN, used in conjunction with the VNIC's hostname"
  type        = string
  default     = null

  validation {
    condition     = var.vcn_dns_label == null || can(regex("^[a-zA-Z][a-zA-Z0-9]{0,14}$", var.vcn_dns_label))
    error_message = "DNS label must start with a letter and contain only alphanumeric characters (max 15 chars)."
  }
}

variable "is_ipv6enabled" {
  description = "(Optional) Whether IPv6 is enabled for the VCN"
  type        = bool
  default     = false
}

variable "byoipv6range_id" {
  description = "(Optional) The OCID of the BYOIP IPv6 range"
  type        = string
  default     = null
}

variable "ipv6cidr_block" {
  description = "(Optional) The IPv6 CIDR block"
  type        = string
  default     = null
}

variable "byoipv6cidr_details" {
  description = "(Optional) List of BYOIP IPv6 CIDR details"
  type = list(object({
    byoipv6range_id = string
    ipv6cidr_block  = string
  }))
  default = []
}

variable "lockdown_default_seclist" {
  description = "(Optional) Whether to remove all rules from default security list"
  type        = bool
  default     = true
}

# -----------------------------------------------------------------------------
# Internet Gateway Variables
# -----------------------------------------------------------------------------

variable "create_internet_gateway" {
  description = "(Optional) Whether to create an Internet Gateway"
  type        = bool
  default     = false
}

variable "internet_gateway_display_name" {
  description = "(Optional) Display name for the Internet Gateway"
  type        = string
  default     = null
}

variable "internet_gateway_enabled" {
  description = "(Optional) Whether the Internet Gateway is enabled"
  type        = bool
  default     = true
}

variable "internet_gateway_route_table_id" {
  description = "(Optional) The OCID of the route table the Internet Gateway is associated with"
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# NAT Gateway Variables
# -----------------------------------------------------------------------------

variable "create_nat_gateway" {
  description = "(Optional) Whether to create a NAT Gateway"
  type        = bool
  default     = false
}

variable "nat_gateway_display_name" {
  description = "(Optional) Display name for the NAT Gateway"
  type        = string
  default     = null
}

variable "nat_gateway_block_traffic" {
  description = "(Optional) Whether the NAT Gateway blocks traffic"
  type        = bool
  default     = false
}

variable "nat_gateway_public_ip_id" {
  description = "(Optional) The OCID of the public IP used by the NAT Gateway"
  type        = string
  default     = null
}

variable "nat_gateway_route_table_id" {
  description = "(Optional) The OCID of the route table used by the NAT Gateway"
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# Service Gateway Variables
# -----------------------------------------------------------------------------

variable "create_service_gateway" {
  description = "(Optional) Whether to create a Service Gateway"
  type        = bool
  default     = false
}

variable "service_gateway_display_name" {
  description = "(Optional) Display name for the Service Gateway"
  type        = string
  default     = null
}

variable "service_gateway_route_table_id" {
  description = "(Optional) The OCID of the route table the Service Gateway is associated with"
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# Tags
# -----------------------------------------------------------------------------

variable "freeform_tags" {
  description = "(Optional) Free-form tags for this resource"
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "(Optional) Defined tags for this resource"
  type        = map(string)
  default     = {}
}
