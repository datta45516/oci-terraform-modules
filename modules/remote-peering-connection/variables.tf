
variable "compartment_id" {
  description = "(Required) The OCID of the compartment"
  type        = string
}

variable "drg_id" {
  description = "(Required) The OCID of the DRG"
  type        = string
}

variable "display_name" {
  description = "(Required) A user-friendly name for the RPC"
  type        = string
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "peer_id" {
  description = "(Optional) The OCID of the RPC to peer with"
  type        = string
  default     = null
}

variable "peer_region_name" {
  description = "(Optional) The region of the peer"
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
