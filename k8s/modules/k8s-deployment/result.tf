resource "kubernetes_deployment_v1" "db" {
  metadata {
    name = "result"
    labels = {
      App = "result"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "result"
      }
    }
    template {
      metadata {
        labels = {
          App = "result"
        }
      }
      spec {
        container {
          name  = "result"
          image = "dockersamples/examplevotingapp_result"
          port {
            container_port = 80
            name = "result"
          }
        }
      }
    }
  }
}