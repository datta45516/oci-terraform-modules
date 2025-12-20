variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "display_name"   { type = string, description = "NLB display name." }
variable "subnet_id"      { type = string, description = "Subnet OCID." }
variable "is_private"     { type = bool, description = "Private NLB?", default = true }

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
