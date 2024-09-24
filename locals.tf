locals {
  # Properly format usernames for use in an ARN
  iam_usernames = contains(var.iam_usernames, "root") ? ["root"] : formatlist("user/%s", var.iam_usernames)

  # A list of object actions that allow for reading.
  object_actions_read = ["s3:GetObject*"]

  # A list of object permissions that allow for writing.
  object_actions_write = [
    "s3:DeleteObject",
    "s3:PutObject*",
  ]

  # A list of object permissions that allow for both reading and
  # writing.
  object_actions_read_write = concat(
    local.object_actions_read,
    local.object_actions_write,
  )

  # If var.role_description contains two instances of "%s", use format()
  # to replace the first "%s" with var.s3_bucket and the second "%s"
  # with var.entity_name, otherwise just use var.role_description as is
  role_description = length(regexall(".*%s.*%s.*", var.role_description)) > 0 ? format(var.role_description, var.s3_bucket, var.entity_name) : var.role_description

  # If var.role_name contains two instances of "%s", use format()
  # to replace the first "%s" with var.s3_bucket and the second "%s"
  # with var.entity_name, otherwise just use var.role_name as is.
  # If the role name is longer than 64 characters (the current AWS limit),
  # truncate it to the first 64 characters.
  role_name = substr(length(regexall(".*%s.*%s.*", var.role_name)) > 0 ? format(var.role_name, var.s3_bucket, var.entity_name) : var.role_name, 0, 64)
}
