variable "compartment_id"      { type = string, description = "Compartment OCID." }
variable "display_name"        { type = string, description = "Display name." }
variable "availability_domain" { type = string, description = "Availability Domain." }
variable "shape"               { type = string, description = "Exadata infrastructure shape." }

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
