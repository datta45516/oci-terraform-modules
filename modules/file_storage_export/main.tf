terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_file_storage_export" "this" {
  export_set_id  = var.export_set_id
  file_system_id = var.file_system_id
  path           = var.path

  dynamic "export_options" {
    for_each = var.export_options
    content {
      source                         = export_options.value.source
      access                         = export_options.value.access
      identity_squash                = export_options.value.identity_squash
      require_privileged_source_port = export_options.value.require_privileged_source_port
      anonymous_gid                  = export_options.value.anonymous_gid
      anonymous_uid                  = export_options.value.anonymous_uid
    }
  }
}

output "id" { value = oci_file_storage_export.this.id }
output "path" { value = oci_file_storage_export.this.path }
