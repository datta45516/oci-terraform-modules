variable "compartment_id" {
  type        = string
  description = "Compartment OCID."
}

variable "display_name" {
  type        = string
  description = "Custom image display name."
}

variable "instance_id" {
  type        = string
  description = "Source instance OCID to create a custom image from (optional if importing)."
  default     = null

  validation {
    condition     = var.instance_id != null || var.image_source_details != null
    error_message = "Set either instance_id or image_source_details."
  }
}

variable "image_source_details" {
  type = object({
    source_type = string # e.g. objectStorageUri
    source_uri  = string # e.g. https://objectstorage.../n/<ns>/b/<bucket>/o/<object>
  })
  description = "Optional import source details."
  default     = null
}

variable "defined_tags" {
  type        = map(map(string))
  description = "Defined tags."
  default     = {}
}

variable "freeform_tags" {
  type        = map(string)
  description = "Free-form tags."
  default     = {}
}
