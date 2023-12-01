resource "docker_image" "db" {
  name = "postgres:15-alpine"
}

resource "docker_image" "redis" {
  name = "redis:alpine"
}

resource "docker_image" "result" {
  name = "result:dev"
  build {
    context = "${abspath(var.path_to_repo)}/result"
  }
}

# resource "docker_image" "seed" {
#   name = "seed"
#   build {
#     context = "${abspath(var.path_to_repo)}/seed-data"
#   }
# }

resource "docker_image" "vote" {
  name = "vote:dev"
  build {
    context = "${abspath(var.path_to_repo)}/vote"
    target  = "dev"
  }
}

resource "docker_image" "worker" {
  name = "worker:dev"
  build {
    context = "${abspath(var.path_to_repo)}/worker"
  }
}