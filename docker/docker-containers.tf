
resource "docker_container" "db" {
  name  = "db"
  image = docker_image.db.image_id

  env = [
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=postgres",
  ]

  volumes {
    volume_name = docker_volume.db-data.name
    container_path = "/var/lib/postgresql/data"
  }

  volumes {
    host_path = "${abspath(var.path_to_repo)}/healthchecks"
    container_path = "/healthchecks"
  }

  healthcheck {
    test     = ["/healthchecks/postgres.sh"]
    interval = "5s"
  }

  networks_advanced {
    name = docker_network.back-tier.name 
  }
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

# resource "docker_container" "seed" {
#   name  = "seed"
#   image = docker_image.seed.image_id
#   depends_on = [docker_container.vote]

#   networks_advanced {
#     name = docker_network.front-tier.name
#   }

#   restart  = "no"

#   # profiles = ["seed"]
# }

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


resource "docker_container" "worker" {
  name  = "worker"
  image = docker_image.worker.image_id
  depends_on = [docker_container.redis, docker_container.db]

  networks_advanced {
    name =  docker_network.back-tier.name
  }
}