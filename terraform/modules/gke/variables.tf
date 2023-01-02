variable "project_name" {}
variable "vpc_name" {}
variable "subnet_name" {}
variable "cluster_name" {}
variable "region" {
  
}
variable "node_label_role" {
  
}
variable "disk_type" {
  default = "pd-standard"
}
variable "disk_size_gb" {
  default = "100"
}
#variable "create_service_account" {}
#variable "grant_registry_access" {}
#variable "service_account" {}

# Master
variable "master_version" {
  default = "1.20.10-gke.1600"
}
variable "initial_node_count" {
  default = 1
}

variable "remove_default_node_pool" {
  default = true
}
variable "enable_private_nodes" {
  default = true
}
variable "enable_private_endpoint" {
  default = false
}
variable "min_node_count" {
  default = "1"
}
variable "max_node_count" {
  # default = "2"
}
# variable "enable_private_endpoint" {
#   default = "true"
# }
# variable "enable_private_nodes" {
#   default = "true"
# }
# variable "release_channel" {
#   default = "UNSPECIFIED"
# }
# variable "gke_location" {
# }
# variable "lb_proxy_cidr" {
# }
# variable "gke_network_tag" {
#   default = "k8s-cluster"
# }
# variable "master_ipv4_cidr_block" {
# }

# Node-Pool
# variable "node_count" {
#   default = "1"
# }
# variable "node_pool_name"{
# }
# variable "node_auto_repair" {
#   default = "false"
# }
# variable "node_auto_upgrade" {
#   default = "false"
# }
# variable "machine_type" {}

# variable "create_timeout" {
#   default = "30m"
# }
# variable "update_timeout" {
#   default = "20m"
# }
