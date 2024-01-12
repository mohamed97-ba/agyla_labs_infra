module "notification" {
  source       = "../../modules/notification"
  sender_email = var.sender_email
}

module "security" {
  source = "../../modules/security"
}

module "pipeline" {
  source                        = "../../modules/pipeline"
  lambda_role_arn               = module.security.lambda_role_arn
  sender_email                  = var.sender_email
  serverless_sfn_role_arn       = module.security.serverless_sfn_role_arn
  cloudwatch_serverless_sfn_arn = module.monitoring.cloudwatch_serverless_sfn_arn

  depends_on = [module.security,
  module.monitoring, ]
}
module "monitoring" {
  source = "../../modules/monitoring"
}

module "api" {
  source                              = "../../modules/api"
  cloudwatch_serverless_access_arn    = module.monitoring.cloudwatch_serverless_sfn_arn
  cloudwatch_serverless_logs_role_arn = module.security.lambda_role_arn
  serverless_lambda_api_invoke_arn    = module.pipeline.api_lambda_function_invoke_arn
  serverless_lambda_api_name          = module.pipeline.api_lambda_function_name
}
module "storage" {
  source                 = "../../modules/storage"
  api_gateway_invoke_url = module.api.serverless_api_invoke_url
}

