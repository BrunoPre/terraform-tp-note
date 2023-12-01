module "k8s-service-db" {
  source = "./modules/k8s-services"

  metadata_name = "db"
  label_app = "db"
  spec_type = "ClusterIP"
  ports = [
    {
      port = 5432
      target_port = 5432
      name = "db-service"
    }
  ]
}

module "k8s-service-result" {
  source = "./modules/k8s-services"

  metadata_name = "result"
  label_app = "result"
  spec_type = "NodePort"
  ports = [
    {
      port = 5001
      target_port = 80
      node_port = 31001
      name = "result-service"
    }
  ]
}

module "k8s-service-redis" {
  source = "./modules/k8s-services"

  metadata_name = "redis"
  label_app = "redis"
  spec_type = "ClusterIP"
  ports = [
    {
      port = 6379
      target_port = 6379
      name = "redis-service"
    }
  ]
}


module "k8s-service-vote" {
  source = "./modules/k8s-services"

  metadata_name = "vote"
  label_app = "vote"
  spec_type = "NodePort"
  ports = [
    {
      port = 5000
      target_port = 80
      node_port = 31000
      name = "vote-service"
    }
  ]
}
