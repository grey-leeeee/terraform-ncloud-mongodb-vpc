output "id" {
  description = "The ID of MongoDB instance."
  value       = ncloud_mongodb.mongodb.id
}

output "arbiter_port" {
  description = "TCP port number for access to the MongoDB Arbiter Server."
  value       = ncloud_mongodb.mongodb.arbiter_port
}

output "engine_version" {
  description = "Engine Version."
  value       = ncloud_mongodb.mongodb.engine_version
}

output "region_code" {
  description = "Region code."
  value       = ncloud_mongodb.mongodb.region_code
}

output "zone_code" {
  description = "Zone code."
  value       = ncloud_mongodb.mongodb.zone_code
}

output "access_control_group_no_list" {
  description = "The ID list of the associated Access Control Group."
  value       = ncloud_mongodb.mongodb.access_control_group_no_list
}

output "mongodb_server_list" {
  description = <<EOF
The list of the MongoDB server.
- server_instance_no - Server instance number.
- server_name - Server name.
- server_role - Member or Arbiter or Mongos or Config.
- cluster_role - STAND_ALONE or SINGLE_REPLICA_SET or SHARD or CONFIG or MONGOS.
- product_code - Product code.
- private_domain - Private domain.
- public_domain - Public domain.
- replica_set_name - Replica set name.
- memory_size - Available memory size.
- cpu_count - CPU count.
- data_storage_size - Storage size.
- uptime - Running start time.
- create_date - Server create date.
EOF
  value       = ncloud_mongodb.mongodb.mongodb_server_list
}
