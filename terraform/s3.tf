#creating a bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "fitness.com" #your name or domain_name
}
#providing public access to block
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false #false to untick the marks on block
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
#making our bucket publically accessible
resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::fitness.com/*",
      },
    ],
  })
}

#enabling static website hosting
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.bucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

