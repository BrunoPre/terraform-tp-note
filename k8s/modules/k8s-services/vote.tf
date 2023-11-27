resource "kubernetes_service_v1" "vote" {
  metadata {
    name = "vote"
    labels = {
      App = "vote"
    }
  }
  spec {
    type = "NodePort"
    selector = {
      app = "vote"
    }
    port {
      port        = 5000
      target_port = 80
      node_port = 31000
      name = "vote-service"
    }
  }
}