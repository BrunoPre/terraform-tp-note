variable "metadata_name" {
  type = string
}

variable "label_app" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_ports" {
  type = list(
    object({
      container_port = number
      name           = string
    })
  )
  default = []
}

variable "container_env" {
  type = list(
    object({
      name  = string
      value = string
    })
  )
  default = []
}

variable "container_volume_mount" {
  type = list(
    object({
      name       = string
      mount_path = string
    })
  )
  default = []
}

variable "container_volume" {
  type = list(
    object({
      name = string
    })
  )
  default = []
}

resource "kubernetes_deployment_v1" "deplt" {
  metadata {
    name = var.metadata_name
    labels = {
      App = var.label_app
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = var.label_app
      }
    }
    template {
      metadata {
        labels = {
          App = var.label_app
        }
      }
      spec {
        container {
          name  = var.container_name
          image = var.container_image
          dynamic "port" {
            for_each = var.container_ports
            content {
              container_port = port.value.container_port
              name           = port.value.name
            }
          }
          dynamic "env" {
            for_each = var.container_env
            content {
              name  = env.value.name
              value = env.value.value
            }
          }
          dynamic "volume_mount" {
            for_each = var.container_volume_mount
            content {
              name       = volume_mount.value.name
              mount_path = volume_mount.value.mount_path
            }
          }
        }
        dynamic "volume" {
          for_each = var.container_volume
          content {
            name = volume.value.name
            empty_dir { }
          }
        }
      }
    }
  }
}