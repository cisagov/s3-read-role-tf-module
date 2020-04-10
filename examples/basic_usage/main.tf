provider "aws" {
  alias = "provision-s3-read-roles"
  assume_role {
    role_arn     = "arn:aws:iam::123456789011:role/ProvisionBucketReadRoles"
    session_name = "terraform-example-create-bucket-role"
  }
  region = "us-east-1"
}


#-------------------------------------------------------------------------------
# Configure the module.
#-------------------------------------------------------------------------------
module "s3_read_role" {
  source = "../../"

  providers = {
    aws = aws.provision-s3-read-roles
  }

  account_ids = ["123456789012"]
  entity_name = "example-user"
  s3_bucket   = "example-bucket"
}
