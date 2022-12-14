
resource "aws_s3_bucket" "bucket" {
  bucket = "testbucket1326"
  
  lifecycle_rule {
    id = "Expiration Rule"
    enabled = true

  expiration {
    days = 30
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    id = "all-delete-after-90-days"

    expiration {
      days = 90
    }

    filter {
      and {
        tags = {
         Terraform   = "true"
         env = "dev"
        }
      }
    }

    status = "Enabled"

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }

}
