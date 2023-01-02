locals {
  org_id = var.org_id
  project_id = var.project_id
  project_name = var.project_name
  region = var.region
  subnet_name = var.subnet_name
}

#vpc
module "vpc" {
  source = "../modules/vpc"
  project_name = local.project_name
  region = local.region
  subnet_regions = var.subnet_regions
}

module "vpn" {
  source = "../modules/instance"
  instance_name = "vpn"
  machine_type = "e2-micro"
  region = local.region
  project_id = local.project_id
  compute_image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
  compute_disk_size = "20"
  compute_disk_type = "pd-standard"
  vpc_name = module.vpc.vpc_name
  subnet_name = local.subnet_name
  metadata_startup_script_file =  file("${path.module}/files/vpn.txt")
}

#buckets
#module "bucket_appspot" {
#  source = "../modules/buckets"
#  bucket_location = local.region
#  bucket_name = "example_bucket"
#  project_name = local.project_name
#}

#gke
module "dev_gke" {
  source = "../modules/gke"
  project_name = local.project_name
  vpc_name = module.vpc.vpc_name
  subnet_name = local.subnet_name
  cluster_name = "crew"
  region = local.region
  node_label_role = "global"
  master_version = "1.24.5-gke.600"
  max_node_count = "3"
}