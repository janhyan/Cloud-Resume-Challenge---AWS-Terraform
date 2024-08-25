locals {
  s3_origin_id = "S3SubdomainOrigin"
  acm_cert     = "arn:aws:acm:us-east-1:026090548764:certificate/3095ed3d-e142-4ab9-98ba-1eb5b647c8ab"
}

resource "aws_cloudfront_origin_access_identity" "resume" {
  comment = "Used for accessing hyanjansuamina.com"
}

resource "aws_cloudfront_distribution" "s3_distribution_subdomain" {
  origin {
    domain_name = aws_s3_bucket.resume_buckets[0].bucket_regional_domain_name
    origin_id   = "myresume"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.resume.cloudfront_access_identity_path
    }

  }

  enabled             = true
  aliases             = ["www.hyanjansuamina.com"]
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myresume"

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn = local.acm_cert
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }
  
  price_class = "PriceClass_200"

  tags = {
    Name = "Subdomain"
  }
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "example"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution_root" {
  origin {
    domain_name = aws_s3_bucket_website_configuration.this.website_endpoint
    origin_id   = local.s3_origin_id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1"]
    }
  }

  enabled             = true
  aliases             = ["hyanjansuamina.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn = local.acm_cert
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }
  
  price_class = "PriceClass_200"

    tags = {
    Name = "Root"
  }
}