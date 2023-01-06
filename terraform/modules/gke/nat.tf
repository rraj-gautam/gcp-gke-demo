#cloud router routing to internet
resource "google_compute_router" "cloud_router" {
  name    = "${var.project_name}-${terraform.workspace}-router"
  network = var.vpc_name
  region = var.region
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
    # advertised_ip_ranges {
    #   range = "1.2.3.4"
    # }
    # advertised_ip_ranges {
    #   range = "6.7.0.0/16"
    # }
    keepalive_interval = 30 #default is 20s
  }
}

#cloudnat to nat the public IP(which acts as a gateway to internet) and creates the routes to the internet via nat router.
resource "google_compute_router_nat" "nat" {
  name                               = "${var.project_name}-${terraform.workspace}-nat"
  router                             = google_compute_router.cloud_router.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY" #"AUTO_ONLY" #for automtic allocation of IP address
  nat_ips                            = google_compute_address.nat_address.*.self_link 
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS" #To add all subnetworks automatically, use "ALL_SUBNETWORKS_ALL_IP_RANGES" and remove subnetwork block from below

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
  subnetwork {
    name                    = var.subnet_name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  depends_on = [google_compute_address.nat_address]
    
}

#elastic ip to reserve a IP that will be used for nat gateway.
resource "google_compute_address" "nat_address" {
  count  = 1 #it can be more than one too.
  name   = "${var.project_name}-${terraform.workspace}-nat-ip-${count.index}"
  region = var.region
}