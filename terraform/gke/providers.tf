terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.9.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-test-demo-devops"
    prefix = "terraform/state/gke"
    # credentials = "../credentials.json"
    impersonate_service_account = "<service_account>"
  }
}

locals {
  terraform_service_account = "<service_account>"
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
  target_service_account = local.terraform_service_account
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "1200s"
}

provider "google" {
  project         = var.project_id
  access_token    = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
  region          = var.region
  zone            = var.project_zone
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

provider "kubernetes" {
  alias = "hpa"
  host  = "https://${module.gke.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

provider "kubernetes" {
  alias                  = "vpa"
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}