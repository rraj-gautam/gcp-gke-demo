resource "helm_release" "gitlab_runner" {
  name       = "${terraform.workspace}-gitlab-runner"
  repository = "https://charts.gitlab.io"
  chart      = "gitlab-runner"
  version    = "0.40.0"

  values = [var.helm_var_yaml]

#   set {
#     name  = "cluster.enabled"
#     value = "true"
#   }

#   set {
#     name  = "metrics.enabled"
#     value = "true"
#   }

#   set {
#     name  = "service.annotations.prometheus\\.io/port"
#     value = "9127"
#     type  = "string"
#   }
}