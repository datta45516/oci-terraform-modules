terraform {
  required_version = ">= 1.5.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

resource "oci_core_dedicated_vm_host" "this" {
  availability_domain        = var.availability_domain
  compartment_id             = var.compartment_id
  dedicated_vm_host_shape    = var.dedicated_vm_host_shape
  display_name               = var.display_name
  fault_domain               = var.fault_domain
  defined_tags               = var.defined_tags
  freeform_tags              = var.freeform_tags
}

output "id" {
  value = oci_core_dedicated_vm_host.this.id
}

output "state" {
  value = oci_core_dedicated_vm_host.this.state
}
    
