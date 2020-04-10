output "policy" {
  value       = module.s3_read_role.policy
  description = "The IAM policy for example-user that can read any object from example-bucket."
}

output "role" {
  value       = module.s3_read_role.role
  description = "The IAM role for example-user that can read any object from example-bucket."
}
