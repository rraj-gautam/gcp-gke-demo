resource "google_project" "soobr_282010" {
  auto_create_network = true
  name                = var.project_name
  org_id              = var.org_id
  project_id          = var.project_id
}