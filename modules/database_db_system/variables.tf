variable "availability_domain" { type = string, description = "Availability Domain." }
variable "compartment_id"      { type = string, description = "Compartment OCID." }
variable "subnet_id"           { type = string, description = "Client subnet OCID." }

variable "display_name" { type = string, description = "DB System display name." }
variable "hostname"     { type = string, description = "Hostname for DB system." }
variable "domain"       { type = string, description = "Optional domain.", default = null }

variable "shape" {
  type        = string
  description = "DB system shape."
}

variable "cpu_core_count" { type = number, description = "CPU core count." }
variable "node_count"     { type = number, description = "Node count.", default = 1 }

variable "database_edition" {
  type        = string
  description = "Database edition (e.g., ENTERPRISE_EDITION)."
}

variable "license_model" {
  type        = string
  description = "License model (e.g., LICENSE_INCLUDED or BRING_YOUR_OWN_LICENSE)."
}

variable "ssh_public_keys" {
  type        = list(string)
  description = "List of SSH public keys for the DB system."
}

variable "data_storage_size_in_gb" {
  type        = number
  description = "Data storage size in GB."
}

variable "nsg_ids" {
  type        = list(string)
  description = "Optional NSG OCIDs."
  default     = []
}

variable "db_home_display_name" {
  type        = string
  description = "DB Home display name."
  default     = "dbhome-1"
}

variable "db_version" { type = string, description = "Database version." }

variable "db_admin_password" {
  type        = string
  description = "SYS/SYSTEM admin password."
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "Database name."
}

variable "pdb_name" {
  type        = string
  description = "Optional PDB name (for CDBs)."
  default     = null
}

variable "character_set" {
  type        = string
  description = "DB character set."
  default     = null
}

variable "ncharacter_set" {
  type        = string
  description = "DB national character set."
  default     = null
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
