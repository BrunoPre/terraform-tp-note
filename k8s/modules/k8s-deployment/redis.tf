resource "kubernetes_deployment_v1" "db" {
  metadata {
    name = "redis"
    labels = {
      App = "redis"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "redis"
      }
    }
    template {
      metadata {
        labels = {
          App = "redis"
        }
      }
      spec {
        container {
          name  = "redis"
          image = "redis:alpine"
          port {
            container_port = 6379
            name = "redis"
          }
          volume_mount {
            name = "redis-data"
            mount_path = "/data"
          }
        }
        volume {
          name = "redis-data"
          empty_dir { }
        }
      }
    }
  }
}