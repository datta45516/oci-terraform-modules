variable "availability_domain" { type = string, description = "Availability Domain." }
variable "compartment_id"      { type = string, description = "Compartment OCID." }

variable "display_name" {
  type        = string
  description = "Boot volume display name."
}

variable "size_in_gbs" {
  type        = number
  description = "Boot volume size in GB."
  default     = null
}

variable "vpus_per_gb" {
  type        = number
  description = "VPUs per GB (performance)."
  default     = null
}

variable "source_details" {
  type = object({
    type = string # e.g. bootVolumeBackup
    id   = string # OCID of the source
  })
  description = "Optional source (e.g., create from boot volume backup)."
  default     = null
}

variable "defined_tags"  { type = map(map(string)), default = {} , description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {} , description = "Free-form tags." }
