module "gke" {
  source              = "terraform-google-modules/kubernetes-engine/google"
  project_id          = var.project_id
  name                = var.name
  region              = var.region
  zones               = var.zones
  network             = var.network
  subnetwork          = var.subnetwork
  ip_range_pods       = var.ip_range_pods
  ip_range_services   = var.ip_range_services
  http_load_balancing = var.http_load_balancing
  network_policy      = var.network_policy

  horizontal_pod_autoscaling   = var.horizontal_pod_autoscaling

  filestore_csi_driver = var.filestore_csi_driver

  node_pools              = var.node_pools
  node_pools_oauth_scopes = var.node_pools_oauth_scopes
  node_pools_labels       = var.node_pools_labels
  node_pools_metadata     = var.node_pools_metadata
  node_pools_taints       = var.node_pools_taints
  node_pools_tags         = var.node_pools_tags
}

resource "kubernetes_horizontal_pod_autoscaler" "hpa-test" {
  metadata {
    name      = "hpa-test"
    namespace = "default"
  }

  spec {
    max_replicas = var.hpa_max_replicas
    min_replicas = var.hpa_min_replicas

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "hpa-test-deployment"
    }

    target_cpu_utilization_percentage = var.hpa_cpu_target_percentage
  }
}