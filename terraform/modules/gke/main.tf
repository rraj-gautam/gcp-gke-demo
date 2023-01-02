data "google_compute_subnetwork" "subnetwork" {
  name    = var.subnet_name
  region  = var.region
  project = var.project_name
}

locals {
  gke_network_tag = ["${terraform.workspace}", "k8s"]
}
resource "google_service_account" "gke" {
  account_id   = "${var.cluster_name}-${terraform.workspace}-service-account-id"
  display_name = "${var.cluster_name} ${terraform.workspace} Service Account"
}

resource "google_container_cluster" "primary" {
  name     = "${var.cluster_name}-${terraform.workspace}-gke-cluster"
  # location = "${var.region}-a"
  location = var.region
  network = var.vpc_name
  subnetwork = var.subnet_name
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  initial_node_count       = 1
  remove_default_node_pool = true
  release_channel {
    channel = "UNSPECIFIED"
  }
  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
  private_cluster_config {
    enable_private_nodes = var.enable_private_nodes
    enable_private_endpoint = var.enable_private_endpoint #false will create both private and public endpoints. true will only create private
    master_ipv4_cidr_block = "172.172.172.0/28"
  }  
  ip_allocation_policy {
    #needed to specify this for private clusters
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.cluster_name}-${terraform.workspace}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  # initial_node_count = 1
  # node_count = var.initial_node_count #not used while using autoscaling

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_size_gb = var.disk_size_gb
    disk_type = var.disk_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      env = "${terraform.workspace}"
      role    = var.node_label_role
      project = var.project_name
    }
    tags = local.gke_network_tag
    # taint = 

  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 1
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  network_config {
    enable_private_nodes = var.enable_private_nodes
    # create_pod_range = true
    # pod_ipv4_cidr_block = "10.80.0.0/14"
    # pod_range = "gke-${var.cluster_name}-${var.project_name}-${terraform.workspace}-node-pool-pods"
  }

  autoscaling {
    # min_node_count = var.min_node_count
    # max_node_count = var.max_node_count
    total_min_node_count = var.min_node_count
    total_max_node_count = var.max_node_count
    location_policy = "ANY"
  }

  lifecycle {
    ignore_changes = [network_config]
  }

}