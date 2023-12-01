output "vote_endpoint" {
  value       = "http://localhost:${docker_container.vote.ports[0].external}"
  description = "The URL endpoint to access the vote application"
}

output "result_endpoint" {
  value       = "http://localhost:${docker_container.result.ports[0].external}"
  description = "The URL endpoint to access the result application"
}
