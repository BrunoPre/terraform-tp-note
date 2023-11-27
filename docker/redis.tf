
resource "docker_image" "redis" {
  name = "redis:alpine"
}

resource "docker_container" "redis" {
  name  = "redis"
  image = docker_image.redis.image_id

  volumes {
    host_path = "${abspath(var.path_to_repo)}/healthchecks"
    container_path = "/healthchecks"
  }

  healthcheck {
    test     = ["/healthchecks/redis.sh"]
    interval = "5s"
  }

  networks_advanced {
    name = docker_network.back-tier.name  
  }

}