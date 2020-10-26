
resource "google_storage_bucket" "storage_bucket" {

  name          = var.storage_bucket_name
  force_destroy = var.is_force_destroy_enabled
  location      = var.storage_bucket_location
  storage_class = var.storage_class
  versioning {
    enabled = var.is_versioning_enabled
  }
  logging {
    log_bucket        = var.log_destination_storage_bucket
    log_object_prefix = var.log_object_prefix
  }
  requester_pays = var.is_requester_pays_enabled
}
