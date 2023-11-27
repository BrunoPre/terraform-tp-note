resource "kubernetes_ingress_v1" "frontend-vote-ingress" {
  metadata {
    name = "frontend-vote-ingress"
  }
  spec {
    default_backend {
      service {
        name = "vote"
        port {
          number = 5000
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "frontend-result-ingress" {
  metadata {
    name = "frontend-result-ingress"
  }
  spec {
    default_backend {
      service {
        name = "result"
        port {
          number = 5001
        }
      }
    }
  }
}