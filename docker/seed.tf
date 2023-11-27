# resource "docker_image" "seed" {
#   name = "seed"
#   build {
#     context = "${abspath(var.path_to_repo)}/seed-data"
#   }
# }

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