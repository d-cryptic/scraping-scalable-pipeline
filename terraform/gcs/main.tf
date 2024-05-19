resource "google_storage_bucket" "terraform-test-demo" {
  name          = var.bucket_name
  location      = var.bucket_location
  force_destroy = var.force_destroy
  project       = var.project_id
  labels = {
    name   = var.labels.name
    status = var.labels.status
  }
  versioning {
    enabled = var.versioning_enabled
  }
}