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

variable "bucket_name" {
  description = "The name of the Google Cloud Storage bucket"
  type        = string
}

variable "bucket_location" {
  description = "The location for the Google Cloud Storage bucket"
  type        = string
  default     = "us-east1"
}

variable "force_destroy" {
  description = "Whether to allow deleting the bucket contents when destroying"
  type        = bool
  default     = false
}

variable "labels" {
  description = "A map of labels to assign to the bucket"
  type        = map(string)
}

variable "versioning_enabled" {
  description = "Whether versioning is enabled for the bucket"
  type        = bool
  default     = true
}

variable "service_account" {
  description = "Service Account Email ID"
  type        = string
}
