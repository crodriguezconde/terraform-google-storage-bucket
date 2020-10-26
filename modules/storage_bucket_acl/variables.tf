variable "storage_bucket_name" {
  description = "The name of the Cloud Storage bucket."
  type        = string
}

variable "storage_bucket_access_role" {
  description = "The access permission for the entity. Possible values are OWNER, READER & WRITER."
  type        = string
  validation {
    condition     = contains(["OWNER", "READER", "WRITER"], var.storage_bucket_access_role)
    error_message = "The access permissio for an entity should be OWNER, READER or WRITER."
  }
}

variable "storage_bucket_entity" {
  description = "The entity holding the permission, in one of the following forms: user-userId user-email group-groupId group-email domain-domain project-team-projectId allUsers allAuthenticatedUsers"
  type        = string
}
