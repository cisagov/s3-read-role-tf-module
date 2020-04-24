# IAM policy document that that allows for reading the specified objects
# from the specified S3 bucket
data "aws_iam_policy_document" "s3_read" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    # Create list of ARNs with all combinations of bucket and objects
    resources = [for obj in var.s3_objects : "arn:aws:s3:::${var.bucket_name}/${obj}"]
  }

  # statement {
  #   effect = "Allow"

  #   actions = [
  #     "s3:HeadBucket",
  #   ]

  #   resources = ["*"]
  # }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}"
    ]
  }
}

# The IAM policy for our role
resource "aws_iam_policy" "s3_read" {
  description = var.role_description
  name        = var.role_name
  policy      = data.aws_iam_policy_document.s3_read.json
}
