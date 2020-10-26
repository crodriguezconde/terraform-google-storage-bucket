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

variable "log_destination_storage_bucket" {
  description = "The Google Cloud Storage bucket that will receive log object(s)."
  type        = string
  default     = null
}

variable "log_object_prefix" {
  description = "(Optional, Computed) The object prefix for log objects. If it is not provided, by default Google Cloud Storage sets this to this bucket's name."
  type        = string
  default     = null
}

variable "is_requester_pays_enabled" {
  description = "Enables Requester Pays on a Cloud Storage bucket."
  type        = bool
  default     = false
}
