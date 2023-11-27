variable "path_to_repo" {
  description = "path to app repo"
}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

output "app_endpoint" {
  value       = "http://localhost:${docker_container.vote.ports[0].external}"
  description = "The URL endpoint to access the Guestbook application"
}
