
variable "compartment_id" {
  description = "(Required) The OCID of the compartment"
  type        = string
}

variable "vcn_id" {
  description = "(Required) The OCID of the VCN"
  type        = string
}

variable "display_name" {
  description = "(Required) A user-friendly name for the Internet Gateway"
  type        = string
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "enabled" {
  description = "(Optional) Whether the gateway is enabled"
  type        = bool
  default     = true
}

variable "route_table_id" {
  description = "(Optional) The OCID of the route table the gateway is associated with"
  type        = string
  default     = null
}

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
