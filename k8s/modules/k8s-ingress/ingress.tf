variable "metadata_name" {
    type = string
}

variable "service_name" {
    type = string
}

variable "service_port" {
    type = number
}

resource "kubernetes_ingress_v1" "ingress" {
    metadata {
        name = var.metadata_name
    }
    spec {
        default_backend {
            service {
                name = var.service_name
                port {
                    number = var.service_port
                }
            }
        }
    }
}

output "ingress_ip" {
    value = try(kubernetes_ingress_v1.ingress.status.0.load_balancer.0.ingress.0.ip, "No IP found (yet)")
    description = "The IP address of the ingress"
}