variable "config" {
    type = map(object({
      name = string
      description = string
      source = list(string)
      detail-type = list(string)
    }))
}


variable "sqs_queue_arn" {
  description = "Arn of SQS Queue"
  type = string
}