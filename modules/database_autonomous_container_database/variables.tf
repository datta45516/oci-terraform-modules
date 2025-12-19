variable "compartment_id" { type = string, description = "Compartment OCID." }

variable "autonomous_vm_cluster_id" {
  type        = string
  description = "Autonomous VM cluster OCID hosting the container database."
}

variable "display_name" { type = string, description = "Display name." }

variable "patch_model" {
  type        = string
  description = "Patch model (provider/API allowed values apply)."
  default     = "RELEASE_UPDATES"
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
