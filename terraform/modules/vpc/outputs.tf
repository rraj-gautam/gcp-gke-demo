
output "vpc_id" {
  value = google_compute_network.vpc_network.id
}

output "vpc_selflink"{
  value = google_compute_network.vpc_network.self_link
}

output "vpc_name"{
  value = "${var.project_name}-${terraform.workspace}-vpc"
}

# output "public_subnet_id"{
#   value = google_compute_subnetwork.public_subnet.id
# }

# output "private_subnet_id"{
#   value = google_compute_subnetwork.private_subnet.id
# }

# output "subnet_private_selflink"{
#   value = google_compute_subnetwork.private_subnet.self_link
# }
# output "subnet_public_selflink"{
#   value = google_compute_subnetwork.public_subnet.self_link
# }