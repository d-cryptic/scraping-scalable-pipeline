output "bucket_name" {
  description = "The name of the Google Cloud Storage bucket"
  value       = google_storage_bucket.terraform-test-demo.name
}

output "bucket_location" {
  description = "The location of the Google Cloud Storage bucket"
  value       = google_storage_bucket.terraform-test-demo.location
}

output "force_destroy" {
  description = "Whether to allow deleting the bucket contents when destroying"
  value       = google_storage_bucket.terraform-test-demo.force_destroy
}

output "labels" {
  description = "The labels assigned to the bucket"
  value       = google_storage_bucket.terraform-test-demo.labels
}

output "versioning_enabled" {
  description = "Whether versioning is enabled for the bucket"
  value       = google_storage_bucket.terraform-test-demo.versioning[0].enabled
}

# resource "local_file" "sa_json_file" {
#   content  = base64decode(google_service_account_key.terraform_sa_key.private_key)
#   filename = "../credentials.json"

# }