resource "aws_iam_role" "cuddle_serverless_lambda" {
  name               = "med-lab-serverless-lambda"
  assume_role_policy = data.aws_iam_policy_document.cuddle_serverless_assume_role.json
}


resource "aws_iam_role_policy" "cuddle_serverless_lambda" {
  role = aws_iam_role.cuddle_serverless_lambda.id
  policy = data.aws_iam_policy_document.cuddle_serverless_lambda.json
}

resource "aws_iam_role" "cuddle_serverless_sfn" {
  name               = "med-lab-serverless-sfn"
  assume_role_policy = data.aws_iam_policy_document.cuddle_serverless_assume_role.json
}


resource "aws_iam_role_policy" "cuddle_serverless_sfn" {
  role = aws_iam_role.cuddle_serverless_sfn.id
  policy = data.aws_iam_policy_document.cuddle_serverless_sfn.json
}

