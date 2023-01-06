module "gitlab_runner" {
  source = "../modules/helm/gitlab"
  helm_var_yaml = "${file("./helm/gitlab-values.yaml")}"
}