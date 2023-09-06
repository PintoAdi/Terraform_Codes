resource "aws_s3_bucket" "endpoint-s3" {
  bucket = "vpc-end-terra1"

  tags = {
    Name        = "vpc-end-terra1"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.endpoint-s3.id
  acl    = "public-read-write"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.endpoint-s3.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

  resource "aws_s3_bucket_public_access_block" "pub-s3-acc" {
    bucket = aws_s3_bucket.endpoint-s3.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}



resource "aws_s3_object" "gojoS" {
  bucket = aws_s3_bucket.endpoint-s3.id
  key    = "Gojo.jpg"
  source = "C:\\Gojo.jpg"
  etag = filemd5("C:\\Gojo.jpg")
  acl = "public-read"
  depends_on = [aws_s3_bucket.endpoint-s3]
}

