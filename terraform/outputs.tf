output "api_url" {
  value = aws_apigatewayv2_api.api.api_endpoint
}

output "appointments_endpoint" {
  value = "${aws_apigatewayv2_api.api.api_endpoint}/appointments"
}

output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.cdn.domain_name}"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.frontend.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.appointments.name
}