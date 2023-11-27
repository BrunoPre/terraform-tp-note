resource "docker_image" "db" {
  name = "postgres:15-alpine"
}

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