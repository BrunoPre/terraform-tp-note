module "k8s-ingress-frontend-vote" {
  source = "./modules/k8s-ingress"

  metadata_name = "frontend-vote-ingress"
  # service_name = "vote"
  # service_port = 5000
  service_name = module.k8s-service-vote.svc_name
  service_port = module.k8s-service-vote.svc_port
}

module "k8s-ingress-frontend-result" {
  source = "./modules/k8s-ingress"

  metadata_name = "frontend-result-ingress"
  # service_name = "result"
  service_name = module.k8s-service-result.svc_name
  # service_port = 5001
  service_port = module.k8s-service-result.svc_port
}
