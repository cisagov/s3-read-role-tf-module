output "policy" {
  value       = aws_iam_policy.s3_read
  description = "The IAM policy that can read the specified objects from the specified S3 bucket."
}

output "role" {
  value       = aws_iam_role.s3_read
  description = "The IAM role that can read the specified objects from the specified S3 bucket."
}
