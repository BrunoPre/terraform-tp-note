resource "kubernetes_service_v1" "result" {
  metadata {
    name = "result"
    labels = {
      App = "result"
    }
  }
  spec {
    type = "NodePort"
    selector = {
      app = "result"
    }
    port {
      port        = 5001
      target_port = 80
      node_port = 31001
      name = "result-service"
    }
  }
}