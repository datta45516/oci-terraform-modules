variable "parent_compartment_id" { type = string, description = "Parent compartment OCID." }
variable "name" { type = string, description = "Compartment name." }
variable "description" { type = string, description = "Compartment description." }
variable "enable_delete" { type = bool, default = false, description = "Allow delete." }

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
