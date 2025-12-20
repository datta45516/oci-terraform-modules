variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "namespace"      { type = string, description = "Object Storage namespace." }
variable "name"           { type = string, description = "Bucket name." }

variable "access_type" {
  type        = string
  description = "Bucket access type."
  default     = "NoPublicAccess"
}

variable "storage_tier" {
  type        = string
  description = "Storage tier."
  default     = "Standard"
}

variable "versioning" {
  type        = string
  description = "Versioning state."
  default     = "Disabled"
}

variable "auto_tiering" {
  type        = string
  description = "Auto-tiering state."
  default     = "Disabled"
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
