resource "aws_cloudwatch_log_group" "cuddle_serverless" {
  name = "med-serverless-lab-logs"
}
resource "aws_cloudwatch_log_group" "cuddle_serverless_access_logs" {
  name = "med-serverless-access-lab"
}