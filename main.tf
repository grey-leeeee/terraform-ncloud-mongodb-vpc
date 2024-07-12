resource "ncloud_mongodb" "mongodb" {
  service_name                 = var.service_name
  server_name_prefix           = var.server_name_prefix
  user_name                    = var.user_name
  user_password                = var.user_password
  vpc_no                       = var.vpc_no
  subnet_no                    = var.subnet_no
  cluster_type_code            = var.cluster_type_code
  image_product_code           = var.image_product_code
  member_product_code          = var.member_product_code
  arbiter_product_code         = var.arbiter_product_code
  mongos_product_code          = var.mongos_product_code
  config_product_code          = var.config_product_code
  shard_count                  = var.shard_count
  member_server_count          = var.member_server_count
  arbiter_server_count         = var.arbiter_server_count
  mongos_server_count          = var.mongos_server_count
  config_server_count          = var.config_server_count
  backup_file_retention_period = var.backup_file_retention_period
  backup_time                  = var.backup_time
  data_storage_type            = var.data_storage_type
  member_port                  = var.member_port
}