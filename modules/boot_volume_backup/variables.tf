variable "boot_volume_id" { type = string, description = "Boot volume OCID." }

variable "display_name" {
  type        = string
  description = "Boot volume backup display name."
}

variable "type" {
  type        = string
  description = "Backup type (e.g., FULL, INCREMENTAL)."
  default     = "FULL"
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
