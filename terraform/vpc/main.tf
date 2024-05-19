resource "google_compute_network" "vpc-gke-test-network" {
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
}

resource "google_compute_subnetwork" "vpc-gke-test-subnetwork" {
  name          = var.subnetwork_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc-gke-test-network.id
  secondary_ip_range {
    range_name    = var.range_name_services
    ip_cidr_range = var.ip_cidr_range_services
  }

  secondary_ip_range {
    range_name    = var.range_name_pods
    ip_cidr_range = var.ip_cidr_range_pods
  }
}