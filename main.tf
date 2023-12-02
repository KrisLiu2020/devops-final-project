provider "aws" {
  region = var.aws_region
}

resource "aws_lambda_function" "demo" {
  function_name = "final-project-demo"

  filename = data.archive_file.lambda_demo.output_path

  runtime = "nodejs16.x"
  handler = "demo.handler"

  source_code_hash = data.archive_file.lambda_demo.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
