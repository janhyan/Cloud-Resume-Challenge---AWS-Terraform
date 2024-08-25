data "aws_route53_zone" "this" {
  name = "hyanjansuamina.com"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "www.${data.aws_route53_zone.this.name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution_subdomain.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution_subdomain.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "${data.aws_route53_zone.this.name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution_root.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution_root.hosted_zone_id
    evaluate_target_health = true
  }
}