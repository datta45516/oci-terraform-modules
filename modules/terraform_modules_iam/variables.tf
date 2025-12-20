variable "tenancy_ocid" {
  type        = string
  description = "Tenancy OCID (dynamic groups live at tenancy scope)."
}

variable "create_compartment" { type = bool, default = false, description = "Create a compartment?" }
variable "parent_compartment_id" { type = string, description = "Parent compartment OCID." }

variable "compartment_name" {
  type        = string
  description = "Compartment name (required if create_compartment=true)."
  default     = null
}

variable "compartment_description" {
  type        = string
  description = "Compartment description."
  default     = "Managed by Terraform"
}

variable "enable_delete" { type = bool, default = false, description = "Allow delete of compartment." }

variable "create_dynamic_group" { type = bool, default = false, description = "Create a dynamic group?" }
variable "dynamic_group_name"   { type = string, default = null, description = "Dynamic group name." }
variable "dynamic_group_description" { type = string, default = "Managed by Terraform", description = "Dynamic group description." }
variable "matching_rule"        { type = string, default = null, description = "Dynamic group matching rule." }

variable "create_policy"        { type = bool, default = false, description = "Create a policy?" }
variable "policy_compartment_id" { type = string, default = null, description = "Where to attach policy (defaults to created compartment or parent)." }
variable "policy_name"          { type = string, default = null, description = "Policy name." }
variable "policy_description"   { type = string, default = "Managed by Terraform", description = "Policy description." }
variable "policy_statements"    { type = list(string), default = [], description = "IAM policy statements." }

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
