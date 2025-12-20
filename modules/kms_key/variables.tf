variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "display_name"   { type = string, description = "Key display name." }

variable "management_endpoint" {
  type        = string
  description = "Vault management endpoint URL."
}

variable "protection_mode" {
  type        = string
  description = "Protection mode."
  default     = "HSM"
}

variable "algorithm" {
  type        = string
  description = "Key algorithm (e.g., AES, RSA)."
  default     = "AES"
}

variable "length" {
  type        = number
  description = "Key length (e.g., 256 for AES)."
  default     = 256
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
