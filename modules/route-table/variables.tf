variable "compartment_id" {
  description = "(Required) The OCID of the compartment"
  type        = string
}

variable "vcn_id" {
  description = "(Required) The OCID of the VCN"
  type        = string
}

# -----------------------------------------------------------------------------
# Route Tables
# -----------------------------------------------------------------------------

variable "route_tables" {
  description = "(Optional) Map of route tables to create"
  type = map(object({
    display_name = string
    route_rules = optional(list(object({
      network_entity_id = string
      destination       = string
      destination_type  = optional(string, "CIDR_BLOCK")
      description       = optional(string)
      route_type        = optional(string)
    })), [])
    freeform_tags = optional(map(string), {})
    defined_tags  = optional(map(string), {})
  }))
  default = {}
}

# -----------------------------------------------------------------------------
# Default Route Table
# -----------------------------------------------------------------------------

variable "manage_default_route_table" {
  description = "(Optional) Whether to manage the default route table"
  type        = bool
  default     = false
}

variable "default_route_table_id" {
  description = "(Optional) The OCID of the default route table"
  type        = string
  default     = null
}

variable "default_route_table_display_name" {
  description = "(Optional) Display name for the default route table"
  type        = string
  default     = "Default Route Table"
}

variable "default_route_table_rules" {
  description = "(Optional) Route rules for the default route table"
  type = list(object({
    network_entity_id = string
    destination       = string
    destination_type  = optional(string, "CIDR_BLOCK")
    description       = optional(string)
  }))
  default = []
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
