variable "availability_domain" {
  type        = string
  description = "Availability Domain where the Dedicated VM Host will be created."
}

variable "compartment_id" {
  type        = string
  description = "Compartment OCID."
}

variable "dedicated_vm_host_shape" {
  type        = string
  description = "Dedicated VM host shape name."
}

variable "display_name" {
  type        = string
  description = "Display name for the Dedicated VM Host."
}

variable "fault_domain" {
  type        = string
  description = "Optional fault domain."
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
