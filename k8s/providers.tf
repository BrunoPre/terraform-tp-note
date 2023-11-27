variable "path_to_repo" {
  description = "path to app repo"
}

variable "region" {
  description = "gcp region"
}

variable "zone" {
  description = "gcp zone"
}

variable "json_key_filename" {
  description = "gcp json key filename"
}

variable "project_id" {
  description = "gcp project id"
}


terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.6.0"
    }
    kubernetes = {
        source = "hashicorp/kubernetes"
        version = ">= 2.23.0"
    }
  }
}


provider "google" {
    project = var.project_id
    region  = var.region
    zone    = var.zone 
    credentials = file(var.json_key_filename)
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.mycluster.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.mycluster.master_auth[0].cluster_ca_certificate,
  )
}

### TODO
output "vote_endpoint" {
  value       = "http://localhost:${docker_container.vote.ports[0].external}"
  description = "The URL endpoint to access the vote application"
}

output "result_endpoint" {
  value       = "http://localhost:${docker_container.result.ports[0].external}"
  description = "The URL endpoint to access the result application"
}
