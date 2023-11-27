resource "kubernetes_deployment_v1" "db" {
  metadata {
    name = "vote"
    labels = {
      App = "vote"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "vote"
      }
    }
    template {
      metadata {
        labels = {
          App = "vote"
        }
      }
      spec {
        container {
          name  = "vote"
          image = "dockersamples/examplevotingapp_vote"
          port {
            container_port = 80
            name = "vote"
          }
        }
      }
    }
  }
}