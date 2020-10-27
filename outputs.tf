output "self_link" {
  description = "The URI of the created resource"
  value       = google_storage_bucket.storage_bucket.self_link
}

output "storage_bucket_url" {
  description = "The base URL of the Cloud Storage bucket, in the format gs://<bucket-name>."
  value       = google_storage_bucket.storage_bucket.url
}

output "storage_bucket_name" {
  description = "The base name of the Cloud Storage bucket."
  value       = google_storage_bucket.storage_bucket.name
}
