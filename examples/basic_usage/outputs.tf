output "policy" {
  description = "The IAM policy for example-user that can read any object from example-bucket."
  value       = module.s3_read_role.policy
}

output "role" {
  description = "The IAM role for example-user that can read any object from example-bucket."
  value       = module.s3_read_role.role
}
