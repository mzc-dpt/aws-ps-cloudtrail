resource "random_id" "example" {
  byte_length = 8
}

resource "aws_s3_bucket" "example" {
  bucket        = "example-bucket-${random_id.example.hex}"
  # bucket        = "example-bucket-test123455"
  # force_destroy = true
}

resource "aws_cloudtrail" "example" {
  # depends_on = [aws_s3_bucket_policy.example, aws_s3_bucket.example]
  depends_on = [aws_s3_bucket.example]

  name                          = "example"
  s3_bucket_name                = aws_s3_bucket.example.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  enable_log_file_validation = true
}

//  data "aws_iam_policy_document" "example" {
//   statement {
//     sid    = "AWSCloudTrailAclCheck"
//     effect = "Allow"

//     principals {
//       type        = "Service"
//       identifiers = ["cloudtrail.amazonaws.com"]
//     }

//     actions   = ["s3:GetBucketAcl"]
//     resources = [aws_s3_bucket.example.arn]
//     condition {
//       test     = "StringEquals"
//       variable = "aws:SourceArn"
//       values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/example"]
//     }
//   }

//   statement {
//     sid    = "AWSCloudTrailWrite"
//     effect = "Allow"

//     principals {
//       type        = "Service"
//       identifiers = ["cloudtrail.amazonaws.com"]
//     }

//     actions   = ["s3:PutObject"]
//     resources = ["${aws_s3_bucket.example.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
//     condition {
//       test     = "StringEquals"
//       variable = "s3:x-amz-acl"
//       values   = ["bucket-owner-full-control"]
//     }
//     condition {
//       test     = "StringEquals"
//       variable = "aws:SourceArn"
//       values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/example"]
//     }
//   }
// }

// resource "aws_s3_bucket_policy" "example" {
//   bucket = aws_s3_bucket.example.id
//   policy = data.aws_iam_policy_document.example.json
// }

// data "aws_caller_identity" "current" {}

// data "aws_partition" "current" {}

// data "aws_region" "current" {}
