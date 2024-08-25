variable "s3_buckets" {
  description = "List of bucket names"
  type        = list(string)
  default     = ["resume-subdomain", "resume-root"]
}

variable "domain" {
  description = "List of domains for the website (root and subdomain)"
  type        = list(string)
  default     = ["hyanjansuamina.com", "www.hyanjansuamina.com"]
}
