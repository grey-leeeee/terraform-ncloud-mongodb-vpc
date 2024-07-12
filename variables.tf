variable "service_name" {
  description = "(Required) Service name to create. Enter group name of DB server. Specify the replica set name with the entered DB service name. Only alphanumeric characters, numbers, hyphens (-), and Korean characters are allowed. Duplicate names and changes after creation are prohibited. Min: 3, Max: 15"
  type        = string
  validation {
    condition     = length(var.service_name) >= 3 && length(var.service_name) <= 15
    error_message = "The length of service_name must be between 3 and 15."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9-가-힣]*$", var.service_name))
    error_message = "The service_name must only contain alphanumeric characters, numbers, hyphens (-), and Korean characters."
  }
}

variable "server_name_prefix" {
  description = "(Required) Enter the name prefix of the MongoDb Server. It is created with random text added after the transferred cloudMongoDbServerNamePrefix value to avoid duplicated host names. It must only contain English letters (lowercase), numbers, and hyphens (-). It must start with an English letter and end with an English letter or a number. Min: 3, Max: 15"
  type        = string
  validation {
    condition     = length(var.server_name_prefix) >= 3 && length(var.server_name_prefix) <= 15
    error_message = "The length of server_name_prefix must be between 3 and 15."
  }
  validation {
    condition     = can(regex("^[a-z0-9-]*$", var.server_name_prefix))
    error_message = "The server_name_prefix must only contain English letters (lowercase), numbers, and hyphens (-)."
  }
}

variable "user_name" {
  description = "(Required) Username for access. Must assign username in the role of DB admin. Only English letters, numbers, underscores (_), and hyphens (-) are allowed and it must start with an English letter. Min: 4, Max: 16"
  type        = string
  validation {
    condition     = length(var.user_name) >= 4 && length(var.user_name) <= 16
    error_message = "The length of user_name must be between 4 and 16."
  }
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_-]*$", var.user_name))
    error_message = "The user_name must only contain English letters, numbers, underscores (_), and hyphens (-)."
  }
}

variable "user_password" {
  description = "(Required) Password for access. Must assign password of the username in the role of DB admin. It must have at least 1 English letter, 1 number, and 1 special character.  space. Min: 8, Max: 20"
  type        = string
  validation {
    condition     = length(var.user_password) >= 8 && length(var.user_password) <= 20
    error_message = "The length of user_password must be between 8 and 20."
  }
  validation {
    condition     = can(regex("^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).*$", var.user_password))
    error_message = "The user_password must have at least 1 English letter, 1 number, and 1 special character."
  }
}

variable "vpc_no" {
  description = "(Required) The ID of the associated Vpc."
  type        = string
}

variable "subnet_no" {
  description = "(Required) The ID of the associated Subnet."
  type        = string
}

variable "cluster_type_code" {
  description = "(Required) MongoDB cluster type code determines the cluster type of MongoDB. Options: STAND_ALONE | SINGLE_REPLICA_SET | SHARDED_CLUSTER"
  type        = string
  validation {
    condition     = can(regex("^(STAND_ALONE|SINGLE_REPLICA_SET|SHARDED_CLUSTER)$", var.cluster_type_code))
    error_message = "The cluster_type_code must be either STAND_ALONE, SINGLE_REPLICA_SET, or SHARDED_CLUSTER."
  }
}

variable "image_product_code" {
  description = "(Optional) MongoDB image product code. If not entered, it is created as a default value. It can be obtained through data.ncloud_mongodb_image_products."
  type        = string
  default     = null
}

variable "member_product_code" {
  description = "(Optional) Member server product code. It can be obtained through data.ncloud_mongodb_products. Default: select the minimum specifications and must be based on 1. Memory and 2. CPU"
  type        = string
  default     = null
}

variable "arbiter_product_code" {
  description = "(Optional) Arbiter server product code. It can be obtained through data.ncloud_mongodb_products. Default: select the minimum specifications and must be based on 1. Memory and 2. CPU"
  type        = string
  default     = null
}

variable "mongos_product_code" {
  description = "(Optional) Mongos server product code. It can be obtained through data.ncloud_mongodb_products. Default: select the minimum specifications and must be based on 1. Memory and 2. CPU"
  type        = string
  default     = null
}

variable "config_product_code" {
  description = "(Optional) Config server product code. It can be obtained through data.ncloud_mongodb_products. Default: select the minimum specifications and must be based on 1. Memory and 2. CPU"
  type        = string
  default     = null
}

variable "shard_count" {
  description = "(Optional, Changeable) The number of MongoDB Shards. The number of shards can be defined for sharding. Only 2 or 3 are allowed for the initial configuration. Only enter when cluster_type_code is SHARDED_CLUSTER. Default: 2, Min: 2, Max: 5"
  type        = number
  default     = null
  validation {
    condition     = var.shard_count == null || (var.shard_count >= 2 && var.shard_count <= 5)
    error_message = "The shard_count must be between 2 and 5, or null if sharding is not used."
  }
}

variable "member_server_count" {
  description = "(Optional, Changeable) The number of MongoDB Member Servers. The number of member servers per replica set (or per shard if sharding) can be defined. Selectable between 3 to 7, including arbiter servers. Default : 3, Min: 2, Max: 7"
  type        = number
  default     = 3
  validation {
    condition     = var.member_server_count != null && var.member_server_count >= 2 && var.member_server_count <= 7
    error_message = "The member_server_count must be between 2 and 7."
  }
}

variable "arbiter_server_count" {
  description = "(Optional, Changeable) The number of MongoDB Arbiter servers. You can select whether to use the Arbiter server per Replica Set (for each shard in the case of Sharding). Up to one Arbiter server can be selected. The Arbiter server is provided with a minimum configurable spec. Default: 0, Min: 0, Max: 1"
  type        = number
  default     = 0
  validation {
    condition     = var.arbiter_server_count >= 0 && var.arbiter_server_count <= 1
    error_message = "The arbiter_server_count must be between 0 and 1."
  }
}

variable "mongos_server_count" {
  description = "(Optional, Changeable) The number of MongoDB Mongos servers. If sharding is used, the number of mongos servers can be selected between 2 and 5. If sharding is not used, this value should be set to null."
  type        = number
  default     = null
  validation {
    condition     = var.mongos_server_count == null || (var.mongos_server_count >= 2 && var.mongos_server_count <= 5)
    error_message = "The mongos_server_count must be between 2 and 5, or null if sharding is not used."
  }
}

variable "config_server_count" {
  description = "(Optional, Changeable) The number of MongoDB Config servers. If sharding is used, the config server count can be defined and must initially be exactly 3. After the initial setup, the count can be adjusted between 3 and 7."
  type        = number
  default     = null
  validation {
    condition     = var.config_server_count == null || (var.config_server_count >= 3 && var.config_server_count <= 7)
    error_message = "The config_server_count must be between 3 and 7 or null if sharding is not used."
  }
}

variable "backup_file_retention_period" {
  description = "(Optional) Backups are performed daily and backup files are stored in separate backup storage. Fees are charged based on the space used. Default: 1(1 day), Min: 1, Max: 30"
  type        = number
  default     = 1
  validation {
    condition     = var.backup_file_retention_period >= 1 && var.backup_file_retention_period <= 30
    error_message = "The backup_file_retention_period must be between 1 and 30."
  }
}

variable "backup_time" {
  description = "(Optional) You can set the time when backup is performed. Default: '02:00' in HHMM format. Times must be entered in 15-minute increments."
  type        = string
  default     = "02:00"
  validation {
    condition     = can(regex("^(0[0-9]|1[0-9]|2[0-3])[0-5][0-9]$", var.backup_time))
    error_message = "The backup_time must be in HHMM format and in 15-minute increments."
  }
}

variable "data_storage_type" {
  description = "(Optional) Data storage type. If the generation code is 'G2', you can select either 'SSD' or 'HDD'. If the generation code is 'G3', you can select 'CB1'. It can also be left as null if no specific storage type is needed. Default: 'SSD' for G2, 'CB1' for G3, and 'null' for unspecified."
  type        = string
  default     = null
  validation {
    condition     = var.data_storage_type == null || can(regex("^(SSD|HDD|CB1)$", var.data_storage_type))
    error_message = "The data_storage_type must be either 'SSD', 'HDD', 'CB1', or null."
  }
}

variable "member_port" {
  description = "(Optional) TCP port number for access to the MongoDB Member Server. Default: 17017, Min: 10000, Max: 65535"
  type        = number
  default     = 17017
  validation {
    condition     = var.member_port >= 10000 && var.member_port <= 65535
    error_message = "The member_port must be between 10000 and 65535."
  }
}


