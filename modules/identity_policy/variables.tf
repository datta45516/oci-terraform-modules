variable "compartment_id" { type = string, description = "Compartment OCID where policy is attached." }
variable "name" { type = string, description = "Policy name." }
variable "description" { type = string, description = "Policy description.", default = "Managed by Terraform" }
variable "statements" { type = list(string), description = "Policy statements." }

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
