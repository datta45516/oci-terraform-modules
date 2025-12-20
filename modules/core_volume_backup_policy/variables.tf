variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "display_name"   { type = string, description = "Backup policy display name." }

variable "schedules" {
  type = list(object({
    backup_type       = string
    period            = string
    retention_seconds = number

    time_zone    = optional(string)
    hour_of_day  = optional(number)
    day_of_week  = optional(string)
    day_of_month = optional(number)
    month        = optional(string)

    offset_type    = optional(string)
    offset_seconds = optional(number)
  }))
  description = "Backup schedules."
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
