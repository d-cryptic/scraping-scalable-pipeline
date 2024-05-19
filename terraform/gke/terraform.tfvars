project_id        = "<project_id>"
name              = "gke-test"
network           = "vpc-gke-test-network"
subnetwork        = "vpc-gke-test-subnetwork"
ip_range_pods     = "gke-test-2-pods"
ip_range_services = "gke-test-2-services"
node_pools = [
  {
    name               = "node-pool-1"
    machine_type       = "e2-medium"
    node_locations     = "us-east1-b"
    min_count          = 2
    max_count          = 5
    local_ssd_count    = 0
    spot               = false
    disk_size_gb       = 100
    disk_type          = "pd-standard"
    image_type         = "COS_CONTAINERD"
    enable_gcfs        = false
    enable_gvnic       = false
    auto_repair        = true
    auto_upgrade       = true
    service_account    = "<compute_service_account>"
    preemptible        = false
    initial_node_count = 1
  }
]