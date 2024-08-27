output "s3_website_endpoint" {
  value = aws_s3_bucket_website_configuration.this.website_endpoint
}

output "api_url" {
  value = "${aws_api_gateway_deployment.this.invoke_url}"
}