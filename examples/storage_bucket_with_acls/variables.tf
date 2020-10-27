variable "project_id" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}

variable "storage_bucket_name" {
  description = "The name of the Google Cloud Storage bucket. Every Cloud Storage bucket must be unique."
}

variable "is_force_destroy_enabled" {
  description = "When deleting a Cloud Storage bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run."
}

variable "storage_bucket_location" {
  description = "The Google Cloud Storage bucket location."
}

variable "storage_class" {
  description = "The Storage Classs of the new Google Cloud Storage bucket. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
}

variable "is_versioning_enabled" {
  description = "While set to true, versioning is fully enabled for the Google Cloud Storage bucket."
}

variable "is_requester_pays_enabled" {
  description = "Enables Requester Pays on a Cloud Storage bucket."
}

variable "logging_configuration" {
  description = "Describes the logging configuration for a single Cloud Storage bucket."
}

variable "storage_bucket_access_role" {
	description = "The access permission for the entity. Possible values are OWNER, READER & WRITER."
}

variable "storage_bucket_entity" {
	description = "The entity holding the permission, in one of the following forms: user-userId user-email group-groupId group-email domain-domain project-team-projectId allUsers allAuthenticatedUsers"
}
