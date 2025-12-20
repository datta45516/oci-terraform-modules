variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "subnet_id"      { type = string, description = "Subnet OCID." }

variable "display_name" { type = string, description = "PostgreSQL DB System display name." }
variable "shape"        { type = string, description = "Shape." }
variable "db_version"   { type = string, description = "PostgreSQL version." }

variable "storage_size_in_gbs" {
  type        = number
  description = "Storage size in GB."
}

variable "admin_username" { type = string, description = "Admin username." }
variable "admin_password" { type = string, sensitive = true, description = "Admin password." }

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
