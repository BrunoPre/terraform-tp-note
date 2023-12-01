module "k8s-deployment-db" {
  source = "./modules/k8s-deployment"
  
  metadata_name = "db"
  label_app = "db"
  container_name = "postgres"
  container_image = "postgres:15-alpine"
  container_ports = [
    {
      container_port = 5432
      name = "postgres"
    }
  ]
  container_env = [
    {
      name = "POSTGRES_USER"
      value = "postgres"
    },
    {
      name = "POSTGRES_PASSWORD"
      value = "postgres"
    }
  ]
  container_volume_mount = [
    {
      name = "db-data"
      mount_path = "/var/lib/postgresql/data"
    }
  ]
  container_volume = [
    {
      name = "db-data"
    }
  ]
}

module "k8s-deployment-redis" {
  source = "./modules/k8s-deployment"
  
  metadata_name = "redis"
  label_app = "redis"
  container_name = "redis"
  container_image = "redis:alpine"
  container_ports = [
    {
      container_port = 6379
      name = "redis"
    }
  ]
  container_volume_mount = [
    {
      name = "redis-data"
      mount_path = "/data"
    }
  ]
  container_volume = [
    {
      name = "redis-data"
    }
  ]
}

module "k8s-deployment-vote" {
  source = "./modules/k8s-deployment"
  
  metadata_name = "vote"
  label_app = "vote"
  container_name = "vote"
  container_image = "dockersamples/examplevotingapp_vote"
  container_ports = [
    {
      container_port = 80
      name = "vote"
    }
  ]
}

module "k8s-deployment-result" {
  source = "./modules/k8s-deployment"
  
  metadata_name = "result"
  label_app = "result"
  container_name = "result"
  container_image = "dockersamples/examplevotingapp_result"
  container_ports = [
    {
      container_port = 80
      name = "result"
    }
  ]
}

module "k8s-deployment-worker" {
  source = "./modules/k8s-deployment"
  
  metadata_name = "worker"
  label_app = "worker"
  container_name = "worker"
  container_image = "dockersamples/examplevotingapp_worker"
}