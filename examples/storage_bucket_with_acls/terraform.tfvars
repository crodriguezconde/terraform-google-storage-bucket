storage_bucket_name       = "rodriguezcondeelbucketo"
is_force_destroy_enabled  = true
storage_bucket_location   = "US-CENTRAL1"
storage_class             = "STANDARD"
is_versioning_enabled     = true
is_requester_pays_enabled = false
logging_configuration = {
  is_logging_enabled             = true,
  log_destination_storage_bucket = "playground-bucketo"
  log_object_prefix              = "play"

}

