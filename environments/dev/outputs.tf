output "lambda_arn" {
  value       = module.pipeline.lambda_function_arn
  description = "ARN of Lambda function"
}
output "ses_sender_email" {
  value       = var.sender_email
  description = "Email adress used by SES to send"
}

output "api_invoke_url" {
  value       = module.api.serverless_api_invoke_url
  description = "URL of Api Gateway Stage"
}
output "website_endpoint" {
  value       = module.storage.website_endpoint
  description = "URL of S3 Static Website"
}
output "sfn_arn" {
  value       = module.pipeline.sfn_arn
  description = "ARN of SFN"
}
