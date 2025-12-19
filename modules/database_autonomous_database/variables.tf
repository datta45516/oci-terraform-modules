variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "db_name"        { type = string, description = "ADB DB name." }
variable "display_name"   { type = string, description = "ADB display name." }

variable "db_workload" { type = string, description = "OLTP or DW.", default = "OLTP" }

variable "cpu_core_count" { type = number, description = "CPU core count.", default = 1 }
variable "data_storage_size_in_tbs" { type = number, description = "Storage in TB.", default = 1 }

variable "admin_password" { type = string, sensitive = true, description = "Admin password." }

variable "subnet_id" { type = string, description = "Optional private endpoint subnet OCID.", default = null }
variable "nsg_ids"   { type = list(string), description = "Optional NSG OCIDs.", default = [] }

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
