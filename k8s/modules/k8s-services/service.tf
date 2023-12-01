variable "metadata_name" {
  type = string
}

variable "label_app" {
  type = string
}

variable "spec_type" {
  type = string
}

variable "ports" {
  type = list(
    object({
      port = number
      target_port = number
      node_port = optional(number)
      name = string
    })
  )
}

resource "kubernetes_service_v1" "svc" {
  metadata {
    name = var.metadata_name
    labels = {
      App = var.label_app
    }
  }
  spec {
    type = var.spec_type
    selector = {
      App = var.label_app
    }
    dynamic "port" {
        for_each = var.ports
        content {
            port = port.value.port
            target_port = port.value.target_port
            node_port = port.value.node_port
            name = port.value.name
        }
    }
  }
}

output "svc_port" {
  value = kubernetes_service_v1.svc.spec.0.port.0.port
  description = "The exposed port of the service"
}

output "svc_name" {
  value = kubernetes_service_v1.svc.metadata.0.name
  description = "The service name"
}