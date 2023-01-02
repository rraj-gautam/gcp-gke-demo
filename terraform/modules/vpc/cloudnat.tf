#resource "google_compute_router" "router" {
#    name               = "${var.project_name}-${terraform.workspace}-cloud-router"
#    network            = google_compute_network.vpc_network.id
#    region             = var.region
#}
#
#resource "google_compute_router_nat" "nat" {
#    name                               = "${var.project_name}-${terraform.workspace}-nat"
#    router                             = google_compute_router.router.name
#    region                             = var.region
#    nat_ip_allocate_option             = "AUTO_ONLY"
#    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
#}