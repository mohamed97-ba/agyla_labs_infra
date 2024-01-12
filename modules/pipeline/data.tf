data "archive_file" "lambda" {
  type = "zip"
  source_file = "lambda.py"
  output_path = "lambda_function_payload.zip"
}

data "archive_file" "api_lambda" {
  type        = "zip"
  source_file = "api_lambda.py"
  output_path = "api_lambda_function_payload.zip"
}