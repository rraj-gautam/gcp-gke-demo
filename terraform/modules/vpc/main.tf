# ----------
# 	vpc
# ----------
resource "google_compute_network" "vpc_network" {
  name = "${var.project_name}-${terraform.workspace}-vpc"
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode = var.routing_mode
}

# --------------------------
# Subnet: Private
# ---------------------------
resource "google_compute_subnetwork" "private_subnets" {
  # for_each      = toset(var.subnet_regions)
  for_each = {for obj in var.subnet_regions:  obj.region => obj}
  name          = "${var.project_name}-${terraform.workspace}-private-subnet-${each.value.region}"
  ip_cidr_range = each.value.cidr
  region        = each.value.region
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

# resource "google_compute_subnetwork" "private_subnet_us" {
#   name          = "${var.project_name}-${terraform.workspace}-private-subnet-us"
#   ip_cidr_range = var.private_subnet_cidr_us
#   region        = var.region
#   network       = google_compute_network.vpc_network.id
#   private_ip_google_access = true
# }

# # --------------------------
# # Subnet: Public
# # ---------------------------
# resource "google_compute_subnetwork" "public_subnet" {
#   name          = "${var.project_name}-${terraform.workspace}-public-subnet"
#   ip_cidr_range = var.public_subnet_cidr
#   region        = var.region
#   network       = google_compute_network.vpc_network.id
# }
