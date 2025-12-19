variable "compartment_id" { type = string, description = "Compartment OCID." }

variable "db_name" {
  type        = string
  description = "ADB DB name (uppercase, no special chars; OCI constraints apply)."
}

variable "display_name" { type = string, description = "ADB display name." }

variable "db_workload" {
  type        = string
  description = "ADB workload (e.g., OLTP for ATP, DW for ADW)."
  default     = "OLTP"
}

variable "cpu_core_count" {
  type        = number
  description = "CPU core count."
  default     = 1
}

variable "data_storage_size_in_tbs" {
  type        = number
  description = "Storage in TB."
  default     = 1
}

variable "admin_password" {
  type        = string
  description = "Admin password."
  sensitive   = true
}

variable "is_free_tier" {
  type        = bool
  description = "Enable Always Free (where available)."
  default     = false
}

variable "subnet_id" {
  type        = string
  description = "Optional private endpoint subnet OCID."
  default     = null
}

variable "nsg_ids" {
  type        = list(string)
  description = "Optional NSG OCIDs."
  default     = []
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
