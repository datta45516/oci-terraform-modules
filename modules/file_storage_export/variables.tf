variable "export_set_id"  { type = string, description = "Export set OCID." }
variable "file_system_id" { type = string, description = "File system OCID." }
variable "path"           { type = string, description = "Export path (e.g., /shared)." }

variable "export_options" {
  type = list(object({
    source                         = string
    access                         = optional(string)
    identity_squash                = optional(string)
    require_privileged_source_port = optional(bool)
    anonymous_uid                  = optional(number)
    anonymous_gid                  = optional(number)
  }))
  description = "Export options list."
  default     = []
}
