
variable "compartment_id" {
  description = "(Required) The OCID of the compartment"
  type        = string
}

variable "vcn_id" {
  description = "(Required) The OCID of the VCN"
  type        = string
}

variable "display_name" {
  description = "(Required) A user-friendly name for the LPG"
  type        = string
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "peer_id" {
  description = "(Optional) The OCID of the LPG to peer with"
  type        = string
  default     = null
}

variable "route_table_id" {
  description = "(Optional) The OCID of the route table"
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
