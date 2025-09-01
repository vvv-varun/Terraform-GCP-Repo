output "vpc_self_link" {
  value = google_compute_network.main.self_link
}

output "vpc_name" {
  value = google_compute_network.main.name
}