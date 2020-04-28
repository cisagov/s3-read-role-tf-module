# s3-read-role-tf-module #

[![GitHub Build Status](https://github.com/cisagov/s3-read-role-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/s3-read-role-tf-module/actions)

A Terraform module for creating an IAM role and policy for reading data
from S3 buckets.

## Usage ##

```hcl
module "example" {
  source = "github.com/cisagov/s3-read-role-tf-module"

  providers = {
    aws = aws.provision-s3-read-roles
  }

  account_ids = ["123456789012"]
  entity_name = "example-user"
  s3_bucket   = "example-bucket"
}
```

You will also need a "meta-role" that you can assume for the purposes
of creating the IAM role for reading from S3 buckets.
This meta-role requires a permission policy similar to the following:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Action": [
                "iam:AttachRolePolicy"
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:DeleteRolePolicy",
                "iam:DetachRolePolicy",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "iam:ListAttachedRolePolicies",
                "iam:ListInstanceProfilesForRole",
                "iam:PutRolePolicy",
                "iam:TagRole",
                "iam:UpdateAssumeRolePolicy",
                "iam:UpdateRole",
            ],
            "Resource": "arn:aws:iam::123456789012:role/BucketReadOnly-*"
        },
        {
            "Sid": "2",
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy"
                "iam:CreatePolicyVersion",
                "iam:DeletePolicy",
                "iam:DeletePolicyVersion",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:ListPolicyVersions",
            ],
            "Resource": "arn:aws:iam::123456789012:policy/BucketReadOnly-*"
        }
    ]
}
```

## Examples ##

* [Basic usage](https://github.com/cisagov/s3-read-role-tf-module/tree/develop/examples/basic_usage)

## Providers ##

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account_ids | IDs of AWS accounts that are allowed to assume the role. | `list(string)` | `[]` | no |
| aws_region | The AWS region where the non-global resources are to be provisioned (e.g. "us-east-1"). | `string` | `us-east-1` | no |
| bucket_name | The name of the S3 bucket that the created role will be allowed to read from (e.g. "my-bucket"). | `string` | n/a | yes |
| role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified object(s) in the specified S3 bucket. | `string` | n/a | yes |
| role_name | The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified objects in the specified S3 bucket. | `string` | n/a | yes |
| role_tags | Tags to apply to the IAM role that allows read-only access to the specified S3 buckets. | `map(string)` | `{}` | no |
| s3_objects | A list specifying the objects in the S3 bucket that the created role will be allowed to read (e.g. ["my-file", "projects\example\*"]).  AWS-supported S3 ARN wildcards (* and ?) can be used, but full regular expressions can not.  If not specified, the role will be allowed to read any object in the bucket. | `list(string)` | `["*"]` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| policy | The IAM policy that allows reading of the specified objects from the specified S3 bucket. |
| role | The IAM role that allows reading of the specified objects from the specified S3 bucket. |

## Contributing ##

We welcome contributions!  Please see [here](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
