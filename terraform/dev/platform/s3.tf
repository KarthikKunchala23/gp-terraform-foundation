module "s3_raw" {
  source = "../../../modules/__s3"
  bucket_name = "eng-pl-sindia-2307"
  enable_replication = false
  enable_lifecycle = false
  acl = "private"
  object_ownership = "BucketOwnerPreferred"
  version_status = "Enabled"
  replication_iam_role_arn = null
}