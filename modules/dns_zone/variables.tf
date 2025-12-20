variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "name" { type = string, description = "Zone name (e.g., example.com.)." }

variable "zone_type" {
  type        = string
  description = "Zone type (PRIMARY/SECONDARY)."
  default     = "PRIMARY"
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
