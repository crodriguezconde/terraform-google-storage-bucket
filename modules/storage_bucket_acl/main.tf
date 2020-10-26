resource "google_storage_bucket_access_control" "bucket_access_control" {
  bucket = var.storage_bucket_name
  role   = var.storage_bucket_access_role
  entity = var.storage_bucket_entity
}
