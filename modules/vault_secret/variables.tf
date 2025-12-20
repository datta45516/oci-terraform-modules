variable "compartment_id" { type = string, description = "Compartment OCID." }
variable "vault_id"       { type = string, description = "Vault OCID." }
variable "key_id"         { type = string, description = "KMS key OCID." }
variable "secret_name"    { type = string, description = "Secret name." }

variable "secret_content_plaintext" {
  type        = string
  description = "Plaintext secret content (will be base64-encoded)."
  sensitive   = true
}

variable "defined_tags"  { type = map(map(string)), default = {}, description = "Defined tags." }
variable "freeform_tags" { type = map(string),      default = {}, description = "Free-form tags." }
