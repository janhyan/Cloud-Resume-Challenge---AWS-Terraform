resource "aws_s3_bucket" "resume_buckets" {
  count  = length(var.s3_buckets)
  bucket = var.s3_buckets[count.index]

  tags = {
    Name = "resume"
  }
}

locals {
  content_types = {
    ".html" : "text/html",
    ".css" : "text/css",
    ".js" : "text/javascript",
    ".png" : "image/png",
    ".svg" : "image/png",
    ".jpg" : "image/jpeg"
  }
  source_files = "pages/"
}

# resource "aws_s3_object" "this" {
#   bucket   = aws_s3_bucket.resume_buckets[0].id
#   for_each = fileset("pages", "**/*.*")
#   key      = each.value
#   source   = "pages/${each.value}"

#   content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), null)
# }

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.resume_buckets[1].id

  redirect_all_requests_to {
    host_name = var.domain[1]
    protocol  = "https"
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.resume_buckets[0].id

  policy = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "PolicyForCloudFrontPrivateContent",
    "Statement" : [
      {
        "Sid" : "2",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "${aws_cloudfront_origin_access_identity.resume.iam_arn}"
        },
        "Action" : "s3:GetObject",
        "Resource" : "${aws_s3_bucket.resume_buckets[0].arn}/*"
      }
    ]
    }
  )
}




