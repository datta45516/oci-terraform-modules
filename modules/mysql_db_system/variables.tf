variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "subnet_id"      { type = string, description = "Subnet OCID." }

variable "display_name" { type = string, description = "MySQL DB System display name." }
variable "shape_name"   { type = string, description = "MySQL shape name." }

variable "mysql_version" {
  type        = string
  description = "MySQL version (provider/API allowed values apply)."
  default     = null
}

variable "data_storage_size_in_gb" {
  type        = number
  description = "Storage size in GB."
}

variable "admin_username" { type = string, description = "Admin username." }
variable "admin_password" { type = string, sensitive = true, description = "Admin password." }

variable "configuration_id" {
  type        = string
  description = "Optional MySQL configuration OCID."
  default     = null
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
