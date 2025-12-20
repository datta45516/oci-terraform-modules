output "vcn_id" {
  description = "VCN OCID"
  value       = module.vcn.id
}

output "subnet_id" {
  description = "Subnet OCID"
  value       = module.subnet.id
}

output "drg_id" {
  description = "Dynamic Routing Gateway OCID"
  value       = module.drg.id
}

output "internet_gateway_id" {
  description = "Internet Gateway OCID"
  value       = module.internet_gateway.id
}

output "nat_gateway_id" {
  description = "NAT Gateway OCID"
  value       = module.nat_gateway.id
}

output "service_gateway_id" {
  description = "Service Gateway OCID"
  value       = module.service_gateway.id
}

output "route_table_id" {
  description = "Route Table OCID"
  value       = module.route_table.id
}

############################
# Compute & Scaling Outputs
############################

output "compute_instance_id" {
  description = "Compute Instance OCID"
  value       = module.compute_instance.id
}

output "instance_configuration_id" {
  description = "Instance Configuration OCID"
  value       = module.instance_configuration.id
}

output "instance_pool_id" {
  description = "Instance Pool OCID"
  value       = module.instance_pool.id
}

output "autoscaling_configuration_id" {
  description = "Autoscaling Configuration OCID"
  value       = module.autoscaling.id
}

output "dedicated_vm_host_id" {
  description = "Dedicated VM Host OCID"
  value       = module.dedicated_vm_host.id
}

output "custom_image_id" {
  description = "Custom Image OCID"
  value       = module.custom_image.id
}

output "boot_volume_id" {
  description = "Boot Volume OCID"
  value       = module.boot_volume.id
}

############################
# Database Outputs
############################

output "autonomous_database_id" {
  description = "Autonomous Database OCID"
  value       = module.autonomous_db.id
}

output "db_system_id" {
  description = "DB System OCID"
  value       = module.db_system.id
}

output "mysql_db_system_id" {
  description = "MySQL DB System OCID"
  value       = module.mysql.id
}

output "postgresql_db_system_id" {
  description = "PostgreSQL DB System OCID"
  value       = module.postgresql.id
}

output "nosql_table_id" {
  description = "NoSQL Table OCID"
  value       = module.nosql.id
}

############################
# Storage Outputs
############################

output "object_storage_bucket_id" {
  description = "Object Storage Bucket OCID"
  value       = module.object_storage.id
}

output "block_volume_id" {
  description = "Block Volume OCID"
  value       = module.block_volume.id
}

output "block_volume_backup_id" {
  description = "Block Volume Backup OCID"
  value       = module.block_volume_backup.id
}

output "file_system_id" {
  description = "File Storage File System OCID"
  value       = module.file_storage.id
}

output "mount_target_id" {
  description = "Mount Target OCID"
  value       = module.mount_target.id
}

############################
# OKE & Containers
############################

output "oke_cluster_id" {
  description = "OKE Cluster OCID"
  value       = module.oke_cluster.id
}

output "node_pool_id" {
  description = "OKE Node Pool OCID"
  value       = module.node_pool.id
}

output "container_repository_id" {
  description = "OCI Container Registry Repository OCID"
  value       = module.container_repo.id
}

############################
# Functions
############################

output "functions_application_id" {
  description = "OCI Functions Application OCID"
  value       = module.functions_app.id
}

output "function_id" {
  description = "OCI Function OCID"
  value       = module.function.id
}

############################
# IAM & Security
############################

output "compartment_id" {
  description = "Created Compartment OCID"
  value       = module.compartment.id
}

output "policy_id" {
  description = "IAM Policy OCID"
  value       = module.policy.id
}

output "dynamic_group_id" {
  description = "Dynamic Group OCID"
  value       = module.dynamic_group.id
}

output "vault_secret_id" {
  description = "Vault Secret OCID"
  value       = module.vault_secret.id
}

output "kms_key_id" {
  description = "KMS Key OCID"
  value       = module.kms_key.id
}

output "bastion_id" {
  description = "Bastion OCID"
  value       = module.bastion.id
}

############################
# Load Balancing & DNS
############################

output "load_balancer_id" {
  description = "Load Balancer OCID"
  value       = module.load_balancer.id
}

output "network_load_balancer_id" {
  description = "Network Load Balancer OCID"
  value       = module.network_lb.id
}

output "dns_zone_id" {
  description = "DNS Zone OCID"
  value       = module.dns.id
}
