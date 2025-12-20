variable "compartment_id"     { type = string, description = "Compartment OCID." }
variable "name"               { type = string, description = "Cluster name." }
variable "kubernetes_version" { type = string, description = "Kubernetes version." }
variable "vcn_id"             { type = string, description = "VCN OCID." }

variable "endpoint_subnet_id" { type = string, description = "Endpoint subnet OCID." }
variable "endpoint_is_public" { type = bool, description = "Public endpoint?", default = false }

variable "service_lb_subnet_ids" {
  type        = list(string)
  description = "Subnets for Service LB."
  default     = []
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
