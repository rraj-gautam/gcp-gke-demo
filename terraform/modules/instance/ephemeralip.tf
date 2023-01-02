resource "google_compute_address" "public_static" {
#   count = var.enable_ephemeral_ip == true ? 1 : 0
  name = "${var.instance_name}-public-address"
  project = var.project_id
  region = var.region
}