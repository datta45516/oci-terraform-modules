
variable "compartment_id" {
  description = "(Required) The OCID of the compartment"
  type        = string
}

variable "vcn_id" {
  description = "(Required) The OCID of the VCN"
  type        = string
}

variable "display_name" {
  description = "(Required) A user-friendly name for the Service Gateway"
  type        = string
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "service_id" {
  description = "(Optional) The OCID of the service to enable"
  type        = string
  default     = null
}

variable "service_name_pattern" {
  description = "(Optional) Regex pattern to find the service"
  type        = string
  default     = "All .* Services In Oracle Services Network"
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
