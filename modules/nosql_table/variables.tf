variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "name"           { type = string, description = "NoSQL table name." }

variable "ddl_statement" {
  type        = string
  description = "DDL statement that defines the table."
}

variable "max_read_units"     { type = number, description = "Max read units." }
variable "max_write_units"    { type = number, description = "Max write units." }
variable "max_storage_in_gbs" { type = number, description = "Max storage in GB." }

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
