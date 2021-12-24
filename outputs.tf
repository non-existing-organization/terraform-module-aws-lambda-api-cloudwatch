output "iam_for_lamda" {
  value       = data.aws_iam_role.iam_for_lambda.arn
  description = "The name of the savings_plan_utilization budget"
}

output "lambda_function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.my-slack_event_handler.function_name
}

output "api_base_url" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.my-slack_event_handler.invoke_url
}
