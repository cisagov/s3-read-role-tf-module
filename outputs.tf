output "policy" {
  description = "The IAM policy that can access the specified objects from the specified S3 bucket."
  value       = aws_iam_policy.s3_access
}

output "read_only" {
  description = "A Boolean value indicating whether or not the role and policy are read-only.  If false then the role and policy will allow write permissions."
  value       = var.read_only
}

output "role" {
  description = "The IAM role that can access the specified objects from the specified S3 bucket."
  value       = aws_iam_role.s3_access
}
