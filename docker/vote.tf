resource "docker_image" "vote" {
  name = "vote:dev"
  build {
    context = "${abspath(var.path_to_repo)}/vote"
    target  = "dev"
  }
}

resource "docker_container" "vote" {
  name  = "vote"
  image = docker_image.vote.image_id
  ports {
    internal = "80"
    external = "5000"
  }

  volumes {
    host_path = "${abspath(var.path_to_repo)}/vote"
    container_path = "/usr/local/app"
  }

  depends_on = [docker_container.redis]

  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost"]
    interval = "15s"
    timeout  = "5s"
    retries  = 3
    start_period = "10s"
  }

  networks_advanced {
    name = docker_network.front-tier.name
  }
  
  networks_advanced {
    name = docker_network.back-tier.name
  }
}