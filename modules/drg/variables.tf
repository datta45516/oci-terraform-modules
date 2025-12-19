
variable "compartment_id" {
  description = "(Required) The OCID of the compartment to contain the DRG"
  type        = string

  validation {
    condition     = can(regex("^ocid1\\.(compartment|tenancy)\\.oc[0-9]+\\.[a-z]+\\.[a-z0-9]+$", var.compartment_id))
    error_message = "The compartment_id must be a valid OCID."
  }
}

variable "drg_display_name" {
  description = "(Required) User-friendly name for the DRG"
  type        = string

  validation {
    condition     = length(var.drg_display_name) >= 1 && length(var.drg_display_name) <= 255
    error_message = "DRG name must be between 1 and 255 characters."
  }
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "vcn_attachments" {
  description = "(Optional) Map of VCN attachments to create"
  type = map(object({
    display_name       = string
    vcn_id             = string
    vcn_route_table_id = optional(string)
    drg_route_table_id = optional(string)
    freeform_tags      = optional(map(string), {})
    defined_tags       = optional(map(string), {})
  }))
  default = {}
}

variable "drg_route_tables" {
  description = "(Optional) Map of DRG route tables to create"
  type = map(object({
    display_name                     = string
    import_drg_route_distribution_id = optional(string)
    is_ecmp_enabled                  = optional(bool, false)
    freeform_tags                    = optional(map(string), {})
    defined_tags                     = optional(map(string), {})
  }))
  default = {}
}

variable "drg_route_rules" {
  description = "(Optional) Map of DRG route table route rules"
  type = map(object({
    route_table_key            = optional(string)
    drg_route_table_id         = optional(string)
    destination                = string
    destination_type           = optional(string, "CIDR_BLOCK")
    next_hop_drg_attachment_id = string
  }))
  default = {}
}

variable "drg_route_distributions" {
  description = "(Optional) Map of DRG route distributions to create"
  type = map(object({
    display_name      = string
    distribution_type = string
    freeform_tags     = optional(map(string), {})
    defined_tags      = optional(map(string), {})
  }))
  default = {}
}

variable "drg_distribution_statements" {
  description = "(Optional) Map of DRG route distribution statements"
  type = map(object({
    distribution_key          = optional(string)
    drg_route_distribution_id = optional(string)
    action                    = string
    priority                  = number
    match_criteria = optional(object({
      match_type        = string
      attachment_type   = optional(string)
      drg_attachment_id = optional(string)
    }))
  }))
  default = {}
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
