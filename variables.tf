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

variable "is_lifecycle_rules_enabled" {
  description = "Whether lifecycle configuration(s) are active on the Cloud Storage bucket"
  type        = bool
  default     = false
}

variable "lifecycle_configuration" {
  description = "Defines lifecycle configuration for object(s) inside the Cloud Storage bucket."
  type = list(object({
    lifecycle_action_type        = string,
    target_storage_class         = string,
    minimum_object_age           = number,
    object_creation_date         = string,
    object_with_state            = string,
    object_matches_storage_class = list(string),
    limit_num_object_versions    = number
  }))
  default = [{
    lifecycle_action_type        = "SetStorageClass"
    target_storage_class         = "REGIONAL",
    minimum_object_age           = 0,
    object_creation_date         = null,
    object_with_state            = "LIVE",
    object_matches_storage_class = ["MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE", "ARCHIVE", "STANDARD", "DURABLE_REDUCED_AVAILABILITY"],
    limit_num_object_versions    = null
  }]

  validation {
    # Terraform does not provide an easy way to loop-validate list(s) of object(s), or any type of object(s) using the validation condition. This condition loops each
    # lifecycle_action_type there is (in case the user defines more than 1) and stores the result of the validation in a list like: [true, false, false, true]. 
    # Once we have the list, we have to throw a false to trigger the error_message, as it means that the user has input a not valid action_type. The contains searches
    # for the first false statement that it encounters and throws true if found. As error_message will only trigger if condition is false, we invert the result using !
    condition     = ! contains([for action_type in var.lifecycle_configuration[*].lifecycle_action_type : action_type == "SetStorageClass" || action_type == "Delete" ? true : false], false)
    error_message = "The type of action of the lifecycle rule must be either Delete or SetStorageClass."
  }

  validation {
    condition     = ! contains([for target_storage_class in var.lifecycle_configuration[*].target_storage_class : contains(["MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE", "ARCHIVE"], target_storage_class)], false)
    error_message = "The Storage Class must be MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, or ARCHIVE."
  }

  validation {
    # This condition works like the previous one with the difference that this value could be null. Therefore, if the value is different then null
    # we proceed as we would normally do with the above ones. If the value is null however, the [for...] does not produce any true/false values
    # Therefore, the external contains will run something like contains([],false) which will return false, but as mentioned previously, we want
    # the validation to pass, so we invert it using !
    condition     = ! contains([for with_state in var.lifecycle_configuration[*].object_with_state : contains(["LIVE", "ARCHIVED", "ANY"], with_state) if with_state != null], false)
    error_message = "Supported values are LIVE, ARCHIVED, ANY."
  }
}


