variable "availability_domain" { type = string, description = "Availability Domain." }
variable "compartment_id"      { type = string, description = "Compartment OCID." }
variable "display_name"        { type = string, description = "Volume display name." }

variable "size_in_gbs" { type = number, description = "Size in GB." }

variable "vpus_per_gb" {
  type        = number
  description = "VPUs per GB."
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "Optional KMS key OCID."
  default     = null
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
