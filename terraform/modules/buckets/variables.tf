variable "bucket_location" {
    default = "EUROPE-WEST6"
}
variable "bucket_name" {}
variable "project_name" {}
variable "public_access_prevention" {
  default = "inherited"
}
variable "storage_class" {
  default = "STANDARD"
}
variable "uniform_bucket_level_access" {
  default = false
}