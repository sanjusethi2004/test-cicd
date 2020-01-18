resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
  lifecycle {
      prevent_destroy = true
    }
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}