variable "compartment_id" {
  description = "(Required) The OCID of the compartment"
  type        = string
}

variable "instance_configuration_id" {
  description = "(Required) The OCID of the instance configuration"
  type        = string
}

variable "display_name" {
  description = "(Required) Display name"
  type        = string
}

variable "size" {
  description = "(Required) Number of instances in the pool"
  type        = number
}

variable "state" {
  description = "(Optional) Target state (RUNNING, STOPPED)"
  type        = string
  default     = "RUNNING"
}

variable "placement_configurations" {
  description = "(Required) Placement configurations"
  type = list(object({
    availability_domain = string
    primary_subnet_id   = string
    fault_domains       = optional(list(string))
    secondary_vnic_subnets = optional(list(object({
      display_name = string
      subnet_id    = string
    })), [])
  }))
}

variable "load_balancers" {
  description = "(Optional) Load balancer configurations"
  type = list(object({
    backend_set_name = string
    load_balancer_id = string
    port             = number
    vnic_selection   = string
  }))
  default = []
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
