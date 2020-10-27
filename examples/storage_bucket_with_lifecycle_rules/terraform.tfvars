storage_bucket_name       = "Name of the Cloud Storage bucket"
is_force_destroy_enabled  = false
storage_bucket_location   = "US-CENTRAL1"
storage_class             = "STANDARD"
is_versioning_enabled     = true
is_requester_pays_enabled = false
logging_configuration = {
  is_logging_enabled             = false,
  log_destination_storage_bucket = "Name of the Cloud Storage bucket the logs will be archive on."
  log_object_prefix              = "Prefix name for the Cloud Storage bucket logs"

  # This example creates two different lifecycle rules. Each lifecycle rule is an object and they are collected in a list.
  # The first lifecycle rule will transfer object(s) to COLDLINE storage class if the Storage Class of that object matches to
  # STANDARD. 
  # The second one will change object(s) to STANDARD storage class for object(s) with more than 22 days. 
}
is_lifecycle_rules_enabled = true
lifecycle_configuration = [{
  lifecycle_action_type        = "SetStorageClass"
  target_storage_class         = "COLDLINE"
  minimum_object_age           = 0
  object_creation_date         = null
  object_with_state            = null
  object_matches_storage_class = ["STANDARD"]
  limit_num_object_versions    = null
  },
  {
    lifecycle_action_type        = "SetStorageClass"
    target_storage_class         = "COLDLINE"
    minimum_object_age           = 22
    object_creation_date         = null
    object_with_state            = null
    object_matches_storage_class = null
    limit_num_object_versions    = null
}]

