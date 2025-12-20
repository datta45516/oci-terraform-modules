variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "display_name"   { type = string, description = "LB display name." }

variable "shape" {
  type        = string
  description = "LB shape (e.g., 10Mbps, 100Mbps, flexible)."
  default     = "flexible"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for the LB."
}

variable "is_private" { type = bool, description = "Private LB?", default = true }

variable "minimum_bandwidth_in_mbps" {
  type        = number
  description = "Min bandwidth for flexible shape."
  default     = 10
}

variable "maximum_bandwidth_in_mbps" {
  type        = number
  description = "Max bandwidth for flexible shape."
  default     = 100
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
