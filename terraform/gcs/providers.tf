locals {
  terraform_service_account = var.service_account
}

resource "google_service_account" "terraform_sa" {
  account_id = "<service_account>"
  project    = "<project_id>"
}

resource "time_rotating" "sa_key_rotation" {
  rotation_days = 5
}

resource "google_service_account_key" "terraform_sa_key" {
  service_account_id = google_service_account.terraform_sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
  keepers = {
    rotation_time = time_rotating.sa_key_rotation.rotation_rfc3339
  }
}

resource "google_secret_manager_secret" "terraform_sa_secret" {
  project   = "project-423807"
  secret_id = "terraform-test-secret-2"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "key_secret_version" {
  secret      = google_secret_manager_secret.terraform_sa_secret.id
  secret_data = base64decode(google_service_account_key.terraform_sa_key.private_key)
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }

  backend "gcs" {
    bucket      = "terraform-test-demo-devops"
    prefix      = "terraform/state/gcs"
    # credentials = "../../secrets/credentials.json"
    # encrypt        = true
    impersonate_service_account = "<service_account>"
  }
}

provider "google" {
  alias = "impersonation"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_service_account_access_token" "default" {
  provider               = google.impersonation
  target_service_account = "<service_account>"
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "1200s"
}

provider "google" {
  project         = var.project_id
  access_token    = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
  region          = var.region
  zone            = var.zone
}