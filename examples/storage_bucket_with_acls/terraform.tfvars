storage_bucket_name       = "Name of the Cloud Storage bucket."
is_force_destroy_enabled  = true
storage_bucket_location   = "US-CENTRAL1"
storage_class             = "STANDARD"
is_versioning_enabled     = true
is_requester_pays_enabled = false
logging_configuration = {
  is_logging_enabled             = true,
  log_destination_storage_bucket = "Name of the Cloud Storage bucket it will receive the logs."
  log_object_prefix              = "Prefix for the Cloud Storage logs."

}
storage_bucket_access_role = "READER"
storage_bucket_entity      = "user-example@gmail.com"
