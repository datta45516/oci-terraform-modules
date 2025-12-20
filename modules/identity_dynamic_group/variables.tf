variable "tenancy_ocid" { type = string, description = "Tenancy OCID." }
variable "name" { type = string, description = "Dynamic group name." }
variable "description" { type = string, default = "Managed by Terraform", description = "Description." }
variable "matching_rule" { type = string, description = "Matching rule." }

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
