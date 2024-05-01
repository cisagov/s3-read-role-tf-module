output "policy" {
  description = "The IAM policy that can read the specified objects from the specified S3 bucket."
  value       = aws_iam_policy.s3_read
}

output "role" {
  description = "The IAM role that can read the specified objects from the specified S3 bucket."
  value       = aws_iam_role.s3_read
}
