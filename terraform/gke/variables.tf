variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "project_zone" {
  description = "The Google Cloud project zone"
  type        = string
  default     = "us-east1-b"
}

variable "name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "The region in which resources will be created"
  type        = string
  default     = "us-east1"
}

variable "zones" {
  description = "List of availability zones for the GKE cluster"
  type        = list(string)
  default     = ["us-east1-b"]
}

variable "network" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnetwork" {
  description = "The name of the subnetwork"
  type        = string
}

variable "ip_range_pods" {
  description = "The name of the secondary IP range for pods"
  type        = string
}

variable "ip_range_services" {
  description = "The name of the secondary IP range for services"
  type        = string
}

variable "remove_default_node_pool" {
  description = "Remove default node pool"
  type        = bool
  default     = true
}

variable "http_load_balancing" {
  description = "Enable HTTP load balancing"
  type        = bool
  default     = true
}

variable "network_policy" {
  description = "Enable network policy"
  type        = bool
  default     = false
}

variable "horizontal_pod_autoscaling" {
  description = "Enable horizontal pod autoscaling"
  type        = bool
  default     = true
}

variable "hpa_min_replicas" {
  description = "Minimum number of replicas in HPA"
  type        = number
  default     = 2
}

variable "hpa_max_replicas" {
  description = "Maximum number of replicas in HPA"
  type        = number
  default     = 5
}

variable "hpa_cpu_target_percentage" {
  description = "CPU utilization target percentage for HPA"
  type        = number
  default     = 95
}

# variable "hpa_memory_target_percentage" {
#   description = "Memory utilization target percentage for HPA"
#   type        = number
#   default     = 75
# }

variable "filestore_csi_driver" {
  description = "Enable Filestore CSI driver"
  type        = bool
  default     = truegcloud container clusters get-credentials gke-test --region us-east1 --project project-423807
}

variable "node_pools" {
  description = "List of node pools"
  type = list(object({
    name               = string
    machine_type       = string
    node_locations     = string
    min_count          = number
    max_count          = number
    local_ssd_count    = number
    spot               = bool
    disk_size_gb       = number
    disk_type          = string
    image_type         = string
    enable_gcfs        = bool
    enable_gvnic       = bool
    auto_repair        = bool
    auto_upgrade       = bool
    service_account    = string
    preemptible        = bool
    initial_node_count = number
  }))
}

variable "node_pools_oauth_scopes" {
  description = "OAuth scopes for node pools"
  type        = map(list(string))
  default = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

variable "node_pools_labels" {
  description = "Labels for node pools"
  type        = map(map(string))

  default = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }
}

variable "node_pools_metadata" {
  description = "Metadata for node pools"
  type        = map(map(string))
  default = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

}

variable "node_pools_taints" {
  description = "Taints for node pools"
  type = map(list(object({
    key    = string
    value  = string
    effect = string
  })))
  default = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = "true"
        effect = "PREFER_NO_SCHEDULE"
      }
    ]
  }

}

variable "node_pools_tags" {
  description = "Tags for node pools"
  type        = map(list(string))
  default = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }

}