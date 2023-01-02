resource "kubernetes_horizontal_pod_autoscaler_v2" "hello-world" {
  metadata {
    name = "hello-world-hpa"
  }

  spec {
    min_replicas = 1
    max_replicas = 10

    scale_target_ref {
      kind = "Deployment"
      name = "hello-world-deployment"
    }

    # target_cpu_utilization_percentage = 50

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type  = "Utilization"
          average_utilization = "50"
        }
      }
    }
  }
}