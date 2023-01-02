
resource "google_service_account" "compute_sa" {
  account_id   = "compute-service-account-id"
  display_name = "Compute Service Account"
}

# resource "google_compute_disk" "boot" {
#   name  = "${var.instance_name}-boot-disk"
#   type  = var.compute_disk_type
#   zone  = "${var.region}-a"
#   image = var.compute_image
#   labels = {
#     env = "dev"
#   }
#   physical_block_size_bytes = 4096
# }

resource "google_compute_instance" "default" {
  name         = "${var.instance_name}-${terraform.workspace}"
  machine_type = var.machine_type
  zone         = "${var.region}-a"

  tags = ["${terraform.workspace}", "externalssh"]

  boot_disk {
    # source = google_compute_disk.boot.self_link
    initialize_params {
      image = var.compute_image
      size = var.compute_disk_size
      type = var.compute_disk_type
      labels = {
        env = "${terraform.workspace}"
      }
    }
  }

  // Local SSD disk
#   scratch_disk {
#     interface = "SCSI"
#   }

  network_interface {
    network = var.vpc_name
    subnetwork = var.subnet_name

    access_config {
        nat_ip = google_compute_address.public_static.address
      // added this block to assign Ephemeral public IP
    }
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      metadata_startup_script,
      metadata
    ] 
  }

  metadata_startup_script = var.metadata_startup_script_file

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.compute_sa.email
    scopes = ["cloud-platform"]
  }
}