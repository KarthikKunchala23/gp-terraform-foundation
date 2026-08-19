output "karpenter_sqs_queue_url" {
  description = "SQS Queue URL for Orders microservice"
  value       = aws_sqs_queue.queue.url
}

output "karpenter_sqs_queue_arn" {
  description = "SQS Queue ARN for Orders microservice"
  value       = aws_sqs_queue.queue.arn
}