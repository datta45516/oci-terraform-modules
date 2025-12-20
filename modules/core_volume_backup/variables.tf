variable "volume_id" { type = string, description = "Block volume OCID." }
variable "display_name" { type = string, description = "Backup display name." }

variable "type" {
  type        = string
  description = "Backup type."
  default     = "FULL"
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
