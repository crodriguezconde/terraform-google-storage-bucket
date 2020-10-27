terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "<=3.43"
    }
  }
}

provider "google" {
  project = var.project_id
}

# ======= GOOGLE CLOUD STORAGE BUCKET DEFINITION ======= #

module "gcs_bucket" {

  source = "git::https://github.com/crodriguezconde/terraform-google-storage-bucket.git"
  # Bear in mind the Cloud Storage bucket name must be unique.
  storage_bucket_name       = var.storage_bucket_name
  is_force_destroy_enabled  = var.is_force_destroy_enabled
  storage_bucket_location   = var.storage_bucket_location
  is_versioning_enabled     = var.is_versioning_enabled
  is_requester_pays_enabled = var.is_requester_pays_enabled
  logging_configuration     = var.logging_configuration
}

module "gcs_bucket_acl" {
  source                     = "git::https://github.com/crodriguezconde/terraform-google-storage-bucket.git//modules/storage_bucket_acl"
  storage_bucket_name        = module.gcs_bucket.storage_bucket_name
  storage_bucket_access_role = var.storage_bucket_access_role
  storage_bucket_entity      = var.storage_bucket_entity


}

