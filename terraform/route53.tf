#creating a public hosted zone
resource "aws_route53_zone" "hosted_zone" {
    name = "fitness.com"
}
#for creating a record in cloudfront as alias
resource "aws_route53_record" "cf_alias" {
  name    = "" # Replace with your subdomain
  type    = "A"
  zone_id = aws_route53_zone.hosted_zone.id  # Replace with your Route 53 hosted zone ID

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = false
  }
}