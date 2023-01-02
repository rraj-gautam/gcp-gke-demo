provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "gke_soobr-terraform_europe-west6_crew-dev-gke-cluster"
}