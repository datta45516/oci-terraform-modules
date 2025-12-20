variable "application_id" { type = string, description = "Functions application OCID." }
variable "display_name"   { type = string, description = "Function name." }

variable "image" {
  type        = string
  description = "OCIR image (e.g., <region>.ocir.io/<ns>/<repo>:<tag>)."
}

variable "memory_in_mbs" {
  type        = number
  description = "Memory in MB."
  default     = 256
}

variable "timeout_in_seconds" {
  type        = number
  description = "Timeout in seconds."
  default     = 30
}

variable "config" {
  type        = map(string)
  description = "Optional function config map."
  default     = {}
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
