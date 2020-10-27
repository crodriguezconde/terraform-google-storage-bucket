variable "storage_bucket_name" {
  description = "The name of the Google Cloud Storage bucket. Every Cloud Storage bucket must be unique."
  type        = string
}

variable "is_force_destroy_enabled" {
  description = "When deleting a Cloud Storage bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run."
  type        = bool
  default     = false
}

variable "storage_bucket_location" {
  description = "The Google Cloud Storage bucket location."
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "The Storage Classs of the new Google Cloud Storage bucket. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  type        = string
  default     = "STANDARD"
}

variable "is_versioning_enabled" {
  description = "While set to true, versioning is fully enabled for the Google Cloud Storage bucket."
  type        = bool
  default     = false
}

variable "logging_configuration" {
  description = "An object that describes the behaviour of logging within the Cloud Storage bucket."
  type = object({
    is_logging_enabled             = bool,
    log_destination_storage_bucket = string,
    log_object_prefix              = string
  })
  default = {
    is_logging_enabled             = false,
    log_destination_storage_bucket = "The Google Cloud Storage bucket that will receive log object(s).",
    log_object_prefix              = "(Optional, Computed) The object prefix for log objects. If it is not provided, by default Google Cloud Storage sets this to this bucket's name."
  }
}

variable "is_requester_pays_enabled" {
  description = "Enables Requester Pays on a Cloud Storage bucket."
  type        = bool
  default     = false
}

variable "lifecycle_configuration" {
  description = "Defines lifecycle configuration for object(s) inside the Cloud Storage bucket."
  type = object({
    is_lifecycle_rules_enabled   = bool,
    lifecycle_action_type        = string,
    target_storage_class         = string,
    minimum_object_age           = number,
    object_creation_date         = string,
    object_with_state            = string,
    object_matches_storage_class = list,
    limit_num_object_versions    = number
  })
  default = {
    is_lifecycle_rules_enabled   = false,
    lifecycle_action_type        = null,
    target_storage_class         = null,
    minimum_object_age           = null,
    object_creation_date         = null,
    object_with_state            = null,
    object_matches_storage_class = ["MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE", "ARCHIVE", "STANDARD", "DURABLE_REDUCED_AVAILABILITY"],
    limit_num_object_versions    = null
  }
}

