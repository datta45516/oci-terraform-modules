terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_vault_secret" "this" {
  compartment_id = var.compartment_id
  vault_id       = var.vault_id
  key_id         = var.key_id
  secret_name    = var.secret_name

  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.secret_content_plaintext)
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_vault_secret.this.id }
output "secret_name" { value = oci_vault_secret.this.secret_name }
