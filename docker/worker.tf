resource "docker_image" "worker" {
  name = "worker:dev"
  build {
    context = "${abspath(var.path_to_repo)}/worker"
  }
}

resource "docker_container" "worker" {
  name  = "worker"
  image = docker_image.worker.image_id
  depends_on = [docker_container.redis, docker_container.db]

  networks_advanced {
    name =  docker_network.back-tier.name
  }
}