resource "kubernetes_deployment_v1" "db" {
  metadata {
    name = "db"
    labels = {
      App = "db"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "db"
      }
    }
    template {
      metadata {
        labels = {
          App = "db"
        }
      }
      spec {
        container {
          name  = "postgres"
          image = "postgres:15-alpine"
          port {
            container_port = 5432
            name = "postgres"
          }
          env {
            name = "POSTGRES_USER"
            value = "postgres"
          }
          env {
            name = "POSTGRES_PASSWORD"
            value = "postgres"
          }
          volume_mount {
            name = "db-data"
            mount_path = "/var/lib/postgresql/data"
          }
        }
        volume {
          name = "db-data"
          empty_dir { }
        }
      }
    }
  }
}