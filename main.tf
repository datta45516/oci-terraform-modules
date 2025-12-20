terraform {
  required_version = ">= 1.6.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}
module "vcn" {
  source         = "./modules/vcn"
  compartment_id = var.compartment_id
  display_name   = "main-vcn"
}

module "subnet" {
  source         = "./modules/subnet"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn.id
  display_name   = "public-subnet"
}

module "drg" {
  source         = "./modules/drg"
  compartment_id = var.compartment_id
  display_name   = "main-drg"
}

module "network_security" {
  source         = "./modules/network-security"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn.id
  display_name   = "main-nsg"
}

module "internet_gateway" {
  source         = "./modules/internet-gateway"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn.id
  display_name   = "igw"
}

module "nat_gateway" {
  source         = "./modules/nat-gateway"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn.id
  display_name   = "nat-gw"
}

module "service_gateway" {
  source         = "./modules/service-gateway"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn.id
  display_name   = "svc-gw"
}

module "lpg" {
  source         = "./modules/lpg"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn.id
  display_name   = "lpg"
}

module "rpc" {
  source         = "./modules/rpc"
  compartment_id = var.compartment_id
  drg_id         = module.drg.id
  display_name   = "rpc"
}

module "route_table" {
  source         = "./modules/route-table"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn.id
  display_name   = "main-rt"
}

module "compute_instance" {
  source         = "./modules/compute-instance"
  compartment_id = var.compartment_id
  display_name   = "vm-1"
}

module "instance_configuration" {
  source         = "./modules/instance-configuration"
  compartment_id = var.compartment_id
  display_name   = "ic"
}

module "instance_pool" {
  source                       = "./modules/instance-pool"
  compartment_id               = var.compartment_id
  instance_configuration_id    = module.instance_configuration.id
}

module "autoscaling" {
  source         = "./modules/autoscaling"
  compartment_id = var.compartment_id
  display_name   = "autoscale"
}

module "dedicated_vm_host" {
  source         = "./modules/dedicated-vm-host"
  compartment_id = var.compartment_id
  display_name   = "dedicated-host"
}

module "custom_image" {
  source         = "./modules/image"
  compartment_id = var.compartment_id
  display_name   = "custom-image"
}

module "boot_volume" {
  source         = "./modules/boot-volume"
  compartment_id = var.compartment_id
  ad             = var.availability_domain
}

module "boot_volume_backup" {
  source          = "./modules/boot-volume-backup"
  boot_volume_id = module.boot_volume.id
}

module "adb" {
  source = "./modules/adb"
}

module "db_system" {
  source         = "./modules/db-system"
  compartment_id = var.compartment_id
  display_name   = "db-system"
}

module "autonomous_db" {
  source         = "./modules/autonomous-db"
  compartment_id = var.compartment_id
  display_name   = "atp"
}

module "autonomous_container_db" {
  source         = "./modules/autonomous-container-db"
  compartment_id = var.compartment_id
}

module "mysql" {
  source         = "./modules/mysql"
  compartment_id = var.compartment_id
}

module "nosql" {
  source         = "./modules/nosql"
  compartment_id = var.compartment_id
  display_name   = "nosql-table"
}

module "exadata" {
  source         = "./modules/exadata"
  compartment_id = var.compartment_id
}

module "dataguard" {
  source      = "./modules/dataguard"
  database_id = module.autonomous_db.id
}

module "postgresql" {
  source         = "./modules/postgresql"
  compartment_id = var.compartment_id
}

module "object_storage" {
  source         = "./modules/object-storage"
  compartment_id = var.compartment_id
  display_name   = "bucket1"
}

module "block_volume" {
  source         = "./modules/block-volume"
  compartment_id = var.compartment_id
}

module "block_volume_backup" {
  source    = "./modules/block-volume-backup"
  volume_id = module.block_volume.id
}

module "backup_policy" {
  source         = "./modules/backup-policy"
  compartment_id = var.compartment_id
}

module "file_storage" {
  source         = "./modules/file-storage"
  compartment_id = var.compartment_id
}

module "mount_target" {
  source         = "./modules/mount-target"
  compartment_id = var.compartment_id
}

module "export" {
  source          = "./modules/export"
  export_set_id   = module.mount_target.export_set_id
  file_system_id = module.file_storage.id
}

module "oke" {
  source = "./modules/oke"
}

module "oke_cluster" {
  source         = "./modules/oke-cluster"
  compartment_id = var.compartment_id
  display_name   = "oke-cluster"
}

module "node_pool" {
  source         = "./modules/node-pool"
  compartment_id = var.compartment_id
  cluster_id     = module.oke_cluster.id
}

module "container_repo" {
  source         = "./modules/container-repo"
  compartment_id = var.compartment_id
  display_name   = "repo"
}

module "functions_app" {
  source         = "./modules/functions-app"
  compartment_id = var.compartment_id
  display_name   = "fn-app"
}

module "function" {
  source          = "./modules/function"
  application_id = module.functions_app.id
  display_name   = "fn"
}

module "iam" {
  source = "./modules/iam"
}

module "compartment" {
  source         = "./modules/compartment"
  compartment_id = var.tenancy_ocid
  display_name   = "app-compartment"
}

module "policy" {
  source         = "./modules/policy"
  compartment_id = var.compartment_id
  display_name   = "policy"
  statements     = var.policy_statements
}

module "dynamic_group" {
  source         = "./modules/dynamic-group"
  compartment_id = var.tenancy_ocid
  display_name   = "dg"
}

module "vault_secret" {
  source         = "./modules/vault-secret"
  compartment_id = var.compartment_id
  vault_id       = var.vault_id
}

module "kms_key" {
  source         = "./modules/kms-key"
  compartment_id = var.compartment_id
  display_name   = "kms-key"
}

module "bastion" {
  source         = "./modules/bastion"
  compartment_id = var.compartment_id
  subnet_id      = module.subnet.id
}

module "load_balancer" {
  source         = "./modules/load-balancer"
  compartment_id = var.compartment_id
  display_name   = "lb"
}

module "network_lb" {
  source         = "./modules/network-lb"
  compartment_id = var.compartment_id
}

module "dns" {
  source         = "./modules/dns"
  compartment_id = var.compartment_id
  display_name   = "example.com"
}
