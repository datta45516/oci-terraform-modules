variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "display_name"   { type = string, description = "Functions application name." }

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets used by the app."
}

variable "config" {
  type        = map(string)
  description = "Optional application config map."
  default     = {}
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
