variable "availability_domain" { type = string, description = "Availability Domain." }
variable "compartment_id"      { type = string, description = "Compartment OCID." }
variable "subnet_id"           { type = string, description = "Subnet OCID." }

variable "display_name"   { type = string, description = "Mount target display name." }
variable "hostname_label" { type = string, description = "DNS hostname label." }

variable "nsg_ids" {
  type        = list(string)
  description = "Optional NSG OCIDs."
  default     = []
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
