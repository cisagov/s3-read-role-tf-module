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

    # Calculate all combinations of account_ids and iam_usernames
    principals {
      type        = "AWS"
      identifiers = [for t in setproduct(var.account_ids, local.iam_usernames) : format("arn:aws:iam::${t[0]}:${t[1]}")]
    }
  }
}

# The IAM role
resource "aws_iam_role" "s3_read" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  description        = local.role_description
  name               = local.role_name
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "s3_read" {
  policy_arn = aws_iam_policy.s3_read.arn
  role       = aws_iam_role.s3_read.name
}
