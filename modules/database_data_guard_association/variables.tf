variable "database_id" {
  type        = string
  description = "Primary database OCID (from a DB System DB Home database)."
}

variable "creation_type" {
  type        = string
  description = "Creation type (provider/API allowed values apply)."
}

variable "database_admin_password" {
  type        = string
  description = "Admin password used to create/configure the association."
  sensitive   = true
}

variable "protection_mode" {
  type        = string
  description = "Protection mode (e.g., MAXIMUM_PERFORMANCE)."
  default     = null
}

variable "transport_type" {
  type        = string
  description = "Transport type (e.g., ASYNC)."
  default     = null
}

variable "peer_db_system_id" {
  type        = string
  description = "Peer DB System OCID (for standby)."
  default     = null
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
