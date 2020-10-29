output "self_link" {
  description = "The URI of the created resource"
  value       = module.gcs_bucket.self_link
}

output "storage_bucket_url" {
  description = "The base URL of the Cloud Storage bucket, in the format gs://<bucket-name>."
  value       = module.gcs_bucket.storage_bucket_url
}

output "storage_bucket_name" {
	description = "The name of the Cloud Storage bucket created."
	value       = module.gcs_bucket.storage_bucket_name

}
