resource "random_id" "example" {
  byte_length = 8
}


resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-${random_id.example.hex}"
  acl    = var.acl_enabled ? "private" : "public-read" # ACL을 활성화 또는 비활성화합니다.

  tags = {
    Name        = "ExampleBucket"
    Environment = "Production"
  }
}

# Create an AWS CloudTrail trail
resource "aws_cloudtrail" "example_cloudtrail" {
  name                          = "example-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.example_bucket.id
  include_global_service_events = true
  enable_logging = var.enable_logging
}
