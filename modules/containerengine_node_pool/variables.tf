variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "cluster_id"     { type = string, description = "Cluster OCID." }
variable "name"           { type = string, description = "Node pool name." }

variable "kubernetes_version" { type = string, description = "Kubernetes version." }
variable "node_shape"         { type = string, description = "Node shape." }
variable "size"               { type = number, description = "Node count." }

variable "placement_configs" {
  type = list(object({
    availability_domain = string
    subnet_id           = string
  }))
  description = "Placement configs (AD + subnet)."
}

variable "source_type" {
  type        = string
  description = "Node source type."
  default     = "IMAGE"
}

variable "image_id" { type = string, description = "Node image OCID." }

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
