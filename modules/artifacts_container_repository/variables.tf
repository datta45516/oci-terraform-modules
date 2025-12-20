variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "display_name"   { type = string, description = "Repository name." }

variable "is_public" {
  type        = bool
  description = "Public repo?"
  default     = false
}

variable "is_immutable" {
  type        = bool
  description = "Immutable tags?"
  default     = false
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
