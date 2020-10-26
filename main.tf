resource "google_storage_bucket" "storage_bucket" {

  name          = var.storage_bucket_name
  force_destroy = var.is_force_destroy_enabled
  location      = var.storage_bucket_location
  storage_class = var.storage_class
  versioning {
    enabled = var.is_versioning_enabled
  }
  # There is currently no easy way to handle null blocks within Terraform, so a hacky
  # way to do it is to use the dynamic expression only if logging is enabled.
  dynamic "logging" {
    # for_each needs an iterable list to loop through in order to create as many 
    # "dynamic" objects as items are in the list. Using [*] we ensure that the 
    # iterable list is always 1, as we are only creating 1 config per each bucket in 
    # case the logging configuration is enabled

    for_each = var.logging_configuration["is_logging_enabled"] == false ? [] : var.logging_configuration[*]
    content {
      log_bucket        = var.logging_configuration["log_destination_storage_bucket"]
      log_object_prefix = var.logging_configuration["log_object_prefix"]
    }
  }
  requester_pays = var.is_requester_pays_enabled
}
