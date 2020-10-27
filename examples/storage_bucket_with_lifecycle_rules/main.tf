terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "<= 3.43"
    }
  }
}

provider "google" {
  project = var.project_id
}

# =========== GOOGLE CLOUD STORAGE BUCKET DEFINITION =========== #

module "gcs_bucket" {

  source = "git::https://github.com/crodriguezconde/terraform-google-storage-bucket.git"
  # Bear in mind the Cloud Storage bucket name must be unique.
  storage_bucket_name        = var.storage_bucket_name
  is_force_destroy_enabled   = var.is_force_destroy_enabled
  storage_bucket_location    = var.storage_bucket_location
  is_versioning_enabled      = var.is_versioning_enabled
  is_requester_pays_enabled  = var.is_requester_pays_enabled
  logging_configuration      = var.logging_configuration
  is_lifecycle_rules_enabled = var.is_lifecycle_rules_enabled
  lifecycle_configuration    = var.lifecycle_configuration
}

