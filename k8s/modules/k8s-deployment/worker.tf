resource "kubernetes_deployment_v1" "db" {
  metadata {
    name = "worker"
    labels = {
      App = "worker"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "worker"
      }
    }
    template {
      metadata {
        labels = {
          App = "worker"
        }
      }
      spec {
        container {
          name  = "worker"
          image = "dockersamples/examplevotingapp_vote"
          port {
            container_port = 80
            name = "worker"
          }
        }
      }
    }
  }
}