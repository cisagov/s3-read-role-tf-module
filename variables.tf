# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "entity_name" {
  description = "The name of the entity that the role is being created for (e.g. \"test-user\")."
  type        = string
}

variable "s3_bucket" {
  description = "The name of the S3 bucket that the created role will be allowed to read from (e.g. \"my-bucket\")."
  type        = string
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "account_ids" {
  default     = []
  description = "AWS account IDs that are allowed to assume the role."
  type        = list(string)
}

variable "additional_role_tags" {
  default     = {}
  description = "Tags to apply to the IAM role that allows read-only access to the specified S3 buckets, in addition to the provider's default tags."
  type        = map(string)
}

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources are to be provisioned (e.g. \"us-east-1\")."
  type        = string
}

variable "iam_usernames" {
  default     = ["root"]
  description = "The list of IAM usernames allowed to assume the role.  If not provided, defaults to allowing any user in the specified account(s).  Note that including \"root\" in this list will override any other usernames in the list."
  type        = list(string)
}

variable "read_only" {
  default     = true
  description = "A Boolean value indicating whether or not to make the role read-only.  If false then the role will allow write permissions."
  type        = bool
}

variable "role_description" {
  default     = "Allows read-only access to S3 bucket %s required for %s."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified object(s) in the specified S3 buckets.  Note that the first \"%s\" in this value will get replaced with the s3_bucket variable and the second \"%s\" will get replaced with the entity_name variable.  If there are less than two instances of \"%s\" present in this value, no replacements will be made and the value will be used as is.  Including more than two instances of \"%s\" in this value will result in a Terraform error, so don't do that."
  type        = string
}

variable "role_name" {
  default     = "%s-ReadOnly-%s"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified S3 buckets.  Note that the first \"%s\" in this value will get replaced with the s3_bucket variable and the second \"%s\" will get replaced with the entity_name variable.  If there are less than two instances of \"%s\" present in this value, no replacements will be made and the value will be used as is.  Including more than two instances of \"%s\" in this value will result in a Terraform error, so don't do that.  If the role name is longer than the current AWS limit of 64 characters (either as-is or after \"%s\" replacements), the role name will be truncated to the first 64 characters."
  type        = string
}

variable "s3_objects" {
  default     = ["*"]
  description = "A list specifying the objects in the S3 bucket that the created role will be allowed to read (e.g. [\"my-file\", \"projects\\example\\*\"]).  AWS-supported S3 ARN wildcards (* and ?) can be used, but full regular expressions can not.  If not specified, the role will be allowed to read any object in the bucket."
  type        = list(string)
}
