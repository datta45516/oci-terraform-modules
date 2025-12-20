variable "tenancy_ocid" {
  description = "OCI Tenancy OCID"
  type        = string
}

variable "user_ocid" {
  description = "OCI User OCID"
  type        = string
}

variable "fingerprint" {
  description = "OCI API signing fingerprint"
  type        = string
}

variable "private_key_path" {
  description = "Path to OCI API private key"
  type        = string
}

variable "region" {
  description = "OCI Region (e.g. ap-mumbai-1)"
  type        = string
}

############################
# Global / Common
############################

variable "compartment_id" {
  description = "Primary OCI Compartment OCID"
  type        = string
}

variable "availability_domain" {
  description = "Availability Domain (e.g. kIdk:AP-MUMBAI-1-AD-1)"
  type        = string
}

variable "freeform_tags" {
  description = "Freeform tags applied to resources"
  type        = map(string)
  default     = {}
}

############################
# Networking
############################

variable "vcn_cidr" {
  description = "VCN CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

############################
# Compute / Scaling
############################

variable "instance_shape" {
  description = "Compute instance shape"
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "instance_pool_size" {
  description = "Instance pool size"
  type        = number
  default     = 1
}

############################
# Database
############################

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_admin_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

############################
# Object Storage
############################

variable "bucket_name" {
  description = "Object storage bucket name"
  type        = string
  default     = "app-bucket"
}

############################
# File Storage
############################

variable "export_path" {
  description = "File storage export path"
  type        = string
  default     = "/export"
}

############################
# OKE / Kubernetes
############################

variable "kubernetes_version" {
  description = "OKE Kubernetes version"
  type        = string
  default     = "v1.29.1"
}

############################
# IAM / Security
############################

variable "policy_statements" {
  description = "IAM policy statements"
  type        = list(string)
  default = [
    "Allow service compute to manage all-resources in compartment id ${var.compartment_id}"
  ]
}

variable "vault_id" {
  description = "OCI Vault OCID"
  type        = string
}

############################
# DNS
############################

variable "dns_zone_name" {
  description = "DNS Zone name (example.com)"
  type        = string
}

############################
# Bastion
############################

variable "bastion_client_cidr" {
  description = "Allowed CIDR for Bastion access"
  type        = string
  default     = "0.0.0.0/0"
}
