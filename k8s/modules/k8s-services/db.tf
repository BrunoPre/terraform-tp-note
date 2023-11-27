resource "kubernetes_service_v1" "db" {
  metadata {
    name = "db"
    labels = {
      App = "db"
    }
  }
  spec {
    type = "ClusterIP"
    selector = {
      app = "db"
    }
    port {
      port        = 5432
      target_port = 5432
    }
  }
}