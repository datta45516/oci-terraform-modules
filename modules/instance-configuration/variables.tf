variable "compartment_id" {
  description = "(Required) The OCID of the compartment"
  type        = string
}

variable "display_name" {
  description = "(Required) Display name for the instance configuration"
  type        = string
}

variable "instance_type" {
  description = "(Optional) Instance type"
  type        = string
  default     = "compute"
}

variable "launch_display_name" {
  description = "(Optional) Display name for launched instances"
  type        = string
  default     = null
}

variable "shape" {
  description = "(Required) Instance shape"
  type        = string
}

variable "availability_domain" {
  description = "(Optional) Availability domain"
  type        = string
  default     = null
}

variable "shape_config" {
  description = "(Optional) Shape configuration for flex shapes"
  type = object({
    ocpus         = number
    memory_in_gbs = optional(number)
  })
  default = null
}

variable "subnet_id" {
  description = "(Required) Subnet OCID"
  type        = string
}

variable "assign_public_ip" {
  description = "(Optional) Assign public IP"
  type        = bool
  default     = false
}

variable "nsg_ids" {
  description = "(Optional) NSG OCIDs"
  type        = list(string)
  default     = []
}

variable "source_type" {
  description = "(Optional) Source type"
  type        = string
  default     = "image"
}

variable "image_id" {
  description = "(Required) Image OCID"
  type        = string
}

variable "boot_volume_size_in_gbs" {
  description = "(Optional) Boot volume size"
  type        = number
  default     = 50
}

variable "ssh_public_key" {
  description = "(Optional) SSH public key"
  type        = string
  default     = null
}

variable "user_data" {
  description = "(Optional) User data script"
  type        = string
  default     = null
}

variable "freeform_tags" {
  description = "(Optional) Free-form tags"
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "(Optional) Defined tags"
  type        = map(string)
  default     = {}
}
