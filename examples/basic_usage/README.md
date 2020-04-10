# Create an AWS IAM role for reading from an S3 bucket #

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

## Outputs ##

| Name | Description |
|------|-------------|
| policy | The IAM policy for example-user that can read any object from example-bucket. |
| role | The IAM role for example-user that can read any object from example-bucket. |
