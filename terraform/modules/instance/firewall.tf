resource "google_compute_firewall" "firewall" {
  name    = "${var.instance_name}-firewall-externalssh"
  network = var.vpc_name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  allow {
    protocol = "udp"
    ports = ["1194"]
  }
  source_ranges = ["0.0.0.0/0"] # Not So Secure. Limit the Source Range
  target_tags   = ["externalssh"]
}