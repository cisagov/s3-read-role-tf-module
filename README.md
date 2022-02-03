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

- [Basic usage](https://github.com/cisagov/s3-read-role-tf-module/tree/develop/examples/basic_usage)

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_policy.s3_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.s3_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.s3_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_ids | AWS account IDs that are allowed to assume the role. | `list(string)` | `[]` | no |
| additional\_role\_tags | Tags to apply to the IAM role that allows read-only access to the specified S3 buckets, in addition to the provider's default tags. | `map(string)` | `{}` | no |
| aws\_region | The AWS region where the non-global resources are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| entity\_name | The name of the entity that the role is being created for (e.g. "test-user"). | `string` | n/a | yes |
| iam\_usernames | The list of IAM usernames allowed to assume the role.  If not provided, defaults to allowing any user in the specified account(s).  Note that including "root" in this list will override any other usernames in the list. | `list(string)` | ```[ "root" ]``` | no |
| role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified object(s) in the specified S3 buckets.  Note that the first "%s" in this value will get replaced with the s3\_bucket variable and the second "%s" will get replaced with the entity\_name variable.  If there are less than two instances of "%s" present in this value, no replacements will be made and the value will be used as is.  Including more than two instances of "%s" in this value will result in a Terraform error, so don't do that. | `string` | `"Allows read-only access to S3 bucket %s required for %s."` | no |
| role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified S3 buckets.  Note that the first "%s" in this value will get replaced with the s3\_bucket variable and the second "%s" will get replaced with the entity\_name variable.  If there are less than two instances of "%s" present in this value, no replacements will be made and the value will be used as is.  Including more than two instances of "%s" in this value will result in a Terraform error, so don't do that.  If the role name is longer than the current AWS limit of 64 characters (either as-is or after "%s" replacements), the role name will be truncated to the first 64 characters. | `string` | `"%s-ReadOnly-%s"` | no |
| s3\_bucket | The name of the S3 bucket that the created role will be allowed to read from (e.g. "my-bucket"). | `string` | n/a | yes |
| s3\_objects | A list specifying the objects in the S3 bucket that the created role will be allowed to read (e.g. ["my-file", "projects\example\*"]).  AWS-supported S3 ARN wildcards (* and ?) can be used, but full regular expressions can not.  If not specified, the role will be allowed to read any object in the bucket. | `list(string)` | ```[ "*" ]``` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| policy | The IAM policy that can read the specified objects from the specified S3 bucket. |
| role | The IAM role that can read the specified objects from the specified S3 bucket. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, these are the main directory and
every directory under `examples/`.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
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
