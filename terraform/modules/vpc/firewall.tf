# Allow connection TCP & UDP from private networks

resource "google_compute_firewall" "allow_all_private" {
    for_each = {for obj in var.subnet_regions:  obj.region => obj}
  name    = "${var.project_name}-${terraform.workspace}-firewall-${each.value.region}"
  network = google_compute_network.vpc_network.name
  description = "firewall rule for allowing all from vpc private cidr"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  # source_ranges = ["${var.private_subnet_cidr}"]
  source_ranges = ["${each.value.cidr}"]
}

# resource "google_compute_firewall" "allow_all_udp_private" {
#   name    = "${var.project_name}-${terraform.workspace}-firewall"
#   network = google_compute_network.vpc_network.name
#   description = "firewall rule for allowing all from vpc private cidr"

#   allow {
#     protocol = "udp"
#     ports    = ["0-65535"]
#   }
#   source_ranges = ["${var.private_subnet_cidr}"]
# }

#resource "google_compute_firewall" "vpn_tcp_fw" {
#  name    = "${var.env}-${var.project_name}-vpn-tcp-firewall"
#  network = google_compute_network.vpc_network.name
#  description = "firewall rule for allowing web from VPN only"
#
#  allow {
#    protocol = "tcp"
#    ports    = ["80"]
#  }
#  source_ranges = ["${var.vpn_ip}"]
#}