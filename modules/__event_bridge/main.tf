resource "aws_cloudwatch_event_rule" "rule" {
  for_each = var.config

  name        = each.value.name
  description = each.value.description

  event_pattern = jsonencode({
    source       = each.value.source
    "detail-type" = each.value["detail-type"]
  })
}

resource "aws_cloudwatch_event_target" "target" {
  for_each = var.config

  rule = aws_cloudwatch_event_rule.rule[each.key].name
  target_id = "${each.key}-target"
  arn = var.sqs_queue_arn
}