resource "kubernetes_service_v1" "redis" {
  metadata {
    name = "redis"
    labels = {
      App = "redis"
    }
  }
  spec {
    type = "ClusterIP"
    selector = {
      app = "redis"
    }
    port {
      port        = 6379
      target_port = 6379
      name = "redis-service"
    }
  }
}