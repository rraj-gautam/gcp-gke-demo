resource "google_project_service" "googleapis_com" {
  project = var.project_id
  service = var.service_name

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = false
  disable_on_destroy = true
}

