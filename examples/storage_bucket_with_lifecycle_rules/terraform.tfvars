storage_bucket_name       = "Name of the Cloud Storage bucket."
is_force_destroy_enabled  = false
storage_bucket_location   = "US-CENTRAL1"
storage_class             = "STANDARD"
is_versioning_enabled     = true
is_requester_pays_enabled = false
logging_configuration = {
  is_logging_enabled             = false,
  log_destination_storage_bucket = "Name of the Cloud Storage bucket the logs will be archive on."
  log_object_prefix              = "Prefix name for the Cloud Storage bucket logs"

}
lifecycle_configuration = {
  is_lifecycle_rules_enabled = true,
  lifecycle_action_type      = "SetStorageClass"
  target_storage_class       = "COLDLINE"
  minimum_object_age         = 0
	object_creation_date         = null
  object_with_state            = null
  object_matches_storage_class = null
  limit_num_object_versions    = null
}
