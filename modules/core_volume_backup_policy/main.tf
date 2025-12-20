terraform {
  required_version = ">= 1.5.0"
  required_providers { oci = { source = "oracle/oci", version = ">= 5.0.0" } }
}

resource "oci_core_volume_backup_policy" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name

  dynamic "schedules" {
    for_each = var.schedules
    content {
      backup_type       = schedules.value.backup_type
      period            = schedules.value.period
      retention_seconds = schedules.value.retention_seconds
      time_zone         = schedules.value.time_zone
      hour_of_day       = schedules.value.hour_of_day
      day_of_week       = schedules.value.day_of_week
      day_of_month      = schedules.value.day_of_month
      month             = schedules.value.month
      offset_type       = schedules.value.offset_type
      offset_seconds    = schedules.value.offset_seconds
    }
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

output "id" { value = oci_core_volume_backup_policy.this.id }
output "display_name" { value = oci_core_volume_backup_policy.this.display_name }
