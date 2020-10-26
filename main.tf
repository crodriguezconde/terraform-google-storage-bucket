# This conditions checks whether the user would like to use logging configuration in
# their Cloud Storage bucket. If set to false, the whole logging block will be ignored.

locals {
  logging = var.logging_configuration["is_logging_enabled"] == false ? {} : var.logging_configuration
}


resource "google_storage_bucket" "storage_bucket" {

  name          = var.storage_bucket_name
  force_destroy = var.is_force_destroy_enabled
  location      = var.storage_bucket_location
  storage_class = var.storage_class
  versioning {
    enabled = var.is_versioning_enabled
  }
  dynamic "logging" {
    for_each = local.logging
    content {
      log_bucket        = var.logging_configuration["log_destination_storage_bucket"]
      log_object_prefix = var.logging_configuration["log_object_prefix"]
    }
  }
  requester_pays = var.is_requester_pays_enabled
}
