resource "google_storage_bucket" "soobr_buckets" {
  force_destroy            = false
  location                 = var.location
  name                     = var.bucket_name
  project                  = var.project_name
  public_access_prevention = var.public_access_prevention
  storage_class            = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access #default false
}