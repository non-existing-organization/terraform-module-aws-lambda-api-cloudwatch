output "iam_for_lamda" {
  value       = aws_iam_role.lambda_function_execution_role.arn
  description = "The name of the lambda execution role"
}

output "lambda_function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.lambda_function.function_name
}

output "api_base_url" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.api_gateway_stage.invoke_url
}
