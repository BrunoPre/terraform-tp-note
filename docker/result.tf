
resource "docker_image" "result" {
  name = "result:dev"
  build {
    context = "${abspath(var.path_to_repo)}/result"
  }
}

resource "docker_container" "result" {
  name  = "result"
  image = docker_image.result.image_id
  entrypoint = ["nodemon", "--inspect=0.0.0.0", "server.js"]

  ports {
    internal = "80"
    external = "5001"
  }
  ports {
    internal = "9229"
    external = "9229"
    ip = "127.0.0.1"
  }

  volumes {
    host_path = "${abspath(var.path_to_repo)}/result"
    container_path = "/usr/local/app"
  }
  depends_on = [docker_container.db]

  networks_advanced {
    name = docker_network.front-tier.name
  }
  
  networks_advanced {
    name = docker_network.back-tier.name
  }
}
