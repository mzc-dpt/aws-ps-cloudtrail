resource "random_id" "example" {
  byte_length = 8
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket-${random_id.example.hex}"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}


# Create an AWS CloudTrail trail
resource "aws_cloudtrail" "example_cloudtrail" {
  name                          = "example-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.example.id
  include_global_service_events = true
  # enable_logging = var.enable_logging
}
