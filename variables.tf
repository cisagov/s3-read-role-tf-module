# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "entity_name" {
  type        = string
  description = "The name of the entity that the role is being created for (e.g. \"test-user\")."
}

variable "s3_bucket" {
  type        = string
  description = "The name of the S3 bucket that the created role will be allowed to read from (e.g. \"my-bucket\")."
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "account_ids" {
  type        = list(string)
  description = "AWS account IDs that are allowed to assume the role."
  default     = []
}

variable "additional_role_tags" {
  type        = map(string)
  description = "Tags to apply to the IAM role that allows read-only access to the specified S3 buckets, in addition to the provider's default tags."
  default     = {}
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "iam_usernames" {
  type        = list(string)
  description = "The list of IAM usernames allowed to assume the role.  If not provided, defaults to allowing any user in the specified account(s).  Note that including \"root\" in this list will override any other usernames in the list."
  default     = ["root"]
}

variable "role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified object(s) in the specified S3 buckets.  Note that the first \"%s\" in this value will get replaced with the s3_bucket variable and the second \"%s\" will get replaced with the entity_name variable."
  default     = "Allows read-only access to S3 bucket %s required for %s."
}

variable "role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified S3 buckets.  Note that the first \"%s\" in this value will get replaced with the s3_bucket variable and the second \"%s\" will get replaced with the entity_name variable."
  default     = "%s-ReadOnly-%s"
}

variable "s3_objects" {
  type        = list(string)
  description = "A list specifying the objects in the S3 bucket that the created role will be allowed to read (e.g. [\"my-file\", \"projects\\example\\*\"]).  AWS-supported S3 ARN wildcards (* and ?) can be used, but full regular expressions can not.  If not specified, the role will be allowed to read any object in the bucket."
  default     = ["*"]
}
