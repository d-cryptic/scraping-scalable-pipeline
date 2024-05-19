output "network_id" {
  value = google_compute_network.vpc-gke-test-network.id
}

output "subnetwork_id" {
  value = google_compute_subnetwork.vpc-gke-test-subnetwork.id
}