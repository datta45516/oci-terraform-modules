terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_functions_function" "this" {
  application_id     = var.application_id
  display_name       = var.display_name
  image              = var.image
  memory_in_mbs      = var.memory_in_mbs
  timeout_in_seconds = var.timeout_in_seconds
  config             = var.config

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_functions_function.this.id }
output "invoke_endpoint" { value = oci_functions_function.this.invoke_endpoint }
