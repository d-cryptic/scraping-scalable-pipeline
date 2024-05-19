variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region in which resources will be created"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "The zone in which resources will be created"
  type        = string
  default     = "us-east1-b"
}

variable "network_name" {
  description = "The name of the Google Compute Engine network"
  type        = string
}

variable "auto_create_subnetworks" {
  description = "Auto-create subnetworks in the Google Compute Engine network"
  type        = bool
  default     = false
}

variable "subnetwork_name" {
  description = "The name of the Google Compute Engine subnetwork"
  type        = string
}

variable "ip_cidr_range" {
  description = "The CIDR range for subnetwork"
  type        = string
}

variable "range_name_services" {
  description = "The name of the secondary IP range for services"
  type        = string
}

variable "ip_cidr_range_services" {
  description = "The CIDR range for the secondary IP range for services"
  type        = string
}

variable "range_name_pods" {
  description = "The name of the secondary IP range for pods"
  type        = string
}

variable "ip_cidr_range_pods" {
  description = "The CIDR range for the secondary IP range for pods"
  type        = string
}