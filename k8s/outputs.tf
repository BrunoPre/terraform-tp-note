
output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.mycluster.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.mycluster.endpoint
  description = "GKE Cluster Host"
}

output "vote_endpoint" {
  value       = "http://${module.k8s-ingress-frontend-vote.ingress_ip}"
  description = "The URL endpoint to access the vote application"
}

output "result_endpoint" {
  value       = "http://${module.k8s-ingress-frontend-result.ingress_ip}"
  description = "The URL endpoint to access the result application"
}
