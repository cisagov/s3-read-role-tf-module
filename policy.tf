# IAM policy document that that allows for reading the specified objects
# from the specified S3 bucket
data "aws_iam_policy_document" "s3_read" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    # Create list of ARNs with all combinations of bucket and objects
    resources = [for t in setproduct([var.s3_bucket], var.s3_objects) : format("arn:aws:s3:::${t[0]}/${t[1]}")]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:HeadBucket",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket}"
    ]
  }
}

# The IAM policy for our role
resource "aws_iam_policy" "s3_read" {
  description = local.role_description
  name        = local.role_name
  policy      = data.aws_iam_policy_document.s3_read.json
}
