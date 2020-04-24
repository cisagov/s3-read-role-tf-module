# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket that the created role will be allowed to read from (e.g. \"my-bucket\")."
}

variable "role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified object(s) in the specified S3 bucket."
}

variable "role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified objects in the specified S3 bucket."
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "account_ids" {
  type        = list(string)
  description = "IDs of AWS accounts that are allowed to assume the role."
  default     = []
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "role_tags" {
  type        = map(string)
  description = "Tags to apply to the IAM role that allows read-only access to the specified S3 buckets."
  default     = {}
}

variable "s3_objects" {
  type        = list(string)
  description = "A list specifying the objects in the S3 bucket that the created role will be allowed to read (e.g. [\"my-file\", \"projects\\example\\*\"]).  AWS-supported S3 ARN wildcards (* and ?) can be used, but full regular expressions can not.  If not specified, the role will be allowed to read any object in the bucket."
  default     = ["*"]
}
