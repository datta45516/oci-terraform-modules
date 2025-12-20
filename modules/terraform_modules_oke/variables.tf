variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "vcn_id"         { type = string, description = "VCN OCID." }

variable "cluster_name" { type = string, description = "OKE cluster name." }

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version."
}

variable "endpoint_subnet_id"  { type = string, description = "Endpoint subnet OCID." }
variable "endpoint_is_public"  { type = bool,   description = "Public endpoint?", default = false }
variable "service_lb_subnet_ids" {
  type        = list(string)
  description = "Subnets for service load balancers."
  default     = []
}

variable "node_pool_name" { type = string, description = "Node pool name.", default = "np-1" }
variable "node_shape"     { type = string, description = "Node shape." }
variable "node_pool_size" { type = number, description = "Number of nodes.", default = 3 }

variable "placement_configs" {
  type = list(object({
    availability_domain = string
    subnet_id           = string
  }))
  description = "Placement configs for nodes (AD + subnet)."
}

variable "node_source_type" {
  type        = string
  description = "Node source type."
  default     = "IMAGE"
}

variable "node_image_id" {
  type        = string
  description = "Node image OCID."
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
