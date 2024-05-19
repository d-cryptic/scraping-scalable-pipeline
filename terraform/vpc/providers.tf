terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-test-demo-devops"
    prefix = "terraform/state/network"
	# credentials = "../credentials.json"
  impersonate_service_account="<service_account>"
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
 provider               	= google.impersonation
 target_service_account 	= local.terraform_service_account
 scopes                 	= ["userinfo-email", "cloud-platform"]
 lifetime               	= "1200s"
}

provider "google" {
 project = var.project_id
 access_token	= data.google_service_account_access_token.default.access_token
 request_timeout 	= "60s"
 region  = var.region
  zone    = var.zone
}