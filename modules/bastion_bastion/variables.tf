variable "compartment_id"   { type = string, description = "Compartment OCID." }
variable "target_subnet_id" { type = string, description = "Target subnet OCID." }

variable "name" { type = string, description = "Bastion name." }

variable "bastion_type" {
  type        = string
  description = "Bastion type."
  default     = "STANDARD"
}

variable "client_cidr_block_allow_list" {
  type        = list(string)
  description = "Allowed client CIDRs."
}

variable "max_session_ttl_in_seconds" {
  type        = number
  description = "Max session TTL seconds."
  default     = 10800
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
