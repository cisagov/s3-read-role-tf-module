# IAM assume role policy document for the IAM role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    principals {
      type        = "AWS"
      identifiers = var.account_ids
    }
  }
}

# The IAM role
resource "aws_iam_role" "s3_read" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  description        = var.role_description
  name               = var.role_name
  tags               = var.role_tags
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "s3_read" {
  policy_arn = aws_iam_policy.s3_read.arn
  role       = aws_iam_role.s3_read.name
}
