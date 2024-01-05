data "aws_iam_policy_document" "cuddle_serverless_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [ 
        "lambda.amazonaws.com", 
        "states.amazonaws.com",
        "apigateway.amazonaws.com",
         ]
    }
    actions = [ "sts:AssumeRole" ]

  }
}
data "aws_iam_policy_document" "cuddle_serverless_lambda" {

  statement {
    effect = "Allow"
    actions = ["ses:*"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = ["sns:*"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      ]
    resources = ["*"]
  }
  statement {
      actions = [ "states:*" ]
      effect = "Allow"
      resources = [ "*" ]
    }
}
data "aws_iam_policy_document" "cuddle_serverless_sfn" {
    statement {
      actions = [ "lambda:*" ]
      effect = "Allow"
      resources = [ "*" ]
    }
    statement {
      actions = [ "sns:*" ]
      effect = "Allow"
      resources = [ "*" ]
    }
    statement {
      actions = [ "logs:*" ]
      effect = "Allow"
      resources = [ "*" ]
    }
    
}
