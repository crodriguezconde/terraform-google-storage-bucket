output "id" {
  description = "An identifier for the resource with format <bucket-name>/<entity>"
  value       = google_storage_bucket_access_control.bucket_access_control.id
}

output "domain" {
  description = "The domain associated with the entity."
  value       = google_storage_bucket_access_control.bucket_access_control.domain
}

output "email" {
  description = "The email address associated with the entity."
  value       = google_storage_bucket_access_control.bucket_access_control.email
}
