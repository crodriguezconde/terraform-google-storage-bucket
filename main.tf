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

    for_each = var.logging_configuration == null ? [] : var.logging_configuration[*]
    content {
      log_bucket        = var.logging_configuration["log_destination_storage_bucket"]
      log_object_prefix = var.logging_configuration["log_object_prefix"]
    }
  }
  requester_pays = var.is_requester_pays_enabled

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_configuration == null ? [] : var.lifecycle_configuration
    # Since a user can create more than 1 lifecycle rule, this dynamic block will be created as many lifecycle rules the user 
    # creates. The lifecycle_rule.key corresponds to the position of the lifecycle rules inside the list, which are in itself
    # object(s) containing the necessary configuration.
    content {
      action {
        type          = var.lifecycle_configuration[lifecycle_rule.key]["lifecycle_action_type"]
        storage_class = var.lifecycle_configuration[lifecycle_rule.key]["lifecycle_action_type"] == "SetStorageClass" ? var.lifecycle_configuration[lifecycle_rule.key]["target_storage_class"] : null
      }
      condition {
        age            = var.lifecycle_configuration[lifecycle_rule.key]["minimum_object_age"]
        created_before = var.lifecycle_configuration[lifecycle_rule.key]["object_creation_date"]
        with_state     = var.lifecycle_configuration[lifecycle_rule.key]["object_with_state"]
        # This validation is necessary, as a null list in Terraform is expressed as [] rather than null, which could cause errors
        # when creating the bucket. As a consequence, if there is a [] per value, we will assume that the user did not configure
        # this property and we will convert it to null before passing it to terraform plan or apply.
        matches_storage_class = var.lifecycle_configuration[lifecycle_rule.key]["object_matches_storage_class"] == [] ? null : var.lifecycle_configuration[lifecycle_rule.key]["object_matches_storage_class"]
        num_newer_versions    = var.is_versioning_enabled == true ? var.lifecycle_configuration[lifecycle_rule.key]["limit_num_object_versions"] : null
      }
    }
  }
}
