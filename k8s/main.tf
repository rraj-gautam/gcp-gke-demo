# resource "kubernetes_manifest" "hello-world" {
#   provider = kubernetes
#   manifest = yamldecode(file("manifests/hello-world-deployment.yml"))
# #   manifest = yamldecode(templatefile(file("manifests/hello-world-deployment.yml", {true=true})))
# }