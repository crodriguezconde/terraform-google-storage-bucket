output "self_link" {
  description = "The URI of the created resource"
  value       = module.gcs_bucket.self_link
}

output "storage_bucket_url" {
  description = "The base URL of the Cloud Storage bucket, in the format gs://<bucket-name>."
  value       = module.gcs_bucket.storage_bucket_url
}

output "id" {
  description = "An identifier for the resource with format <bucket-name>/<entity>"
  value       = module.gcs_bucket_acl.id
}

output "domain" {
  description = "The domain associated with the entity."
  value       = module.gcs_bucket_acl.domain
}

output "email" {
  description = "The email address associated with the entity."
  value       = module.gcs_bucket_acl.email
}
