module "karpenter-event-rules" {
  source = "../../../modules/__event_bridge"
  config = {
    karpenter_health_event = {
        name = "karpenter-health"
        description = "karpenter health events"
        source = ["aws.health"]
        detail-type = ["AWS Health Event"]
    }
    karpenter_spot_interrupt = {
        name = "karpenter-spot-interruption"
        description = "EC2 Spot Interruption Warning → Karpenter SQS Queue"
        source = ["aws.ec2"]
        detail-type = ["EC2 Spot Instance Interruption Warning"]
    }
    karpenter_rebalance = {
        name = "karpenter-rebalance"
        description = "EC2 Instance Rebalance Recommendation → Karpenter SQS Queue"
        source = ["aws.ec2"]
        detail-type = ["EC2 Instance Rebalance Recommendation"]
    }
    karpenter_instance_state = {
        name = "karpenter-instance-state-change"
        description = "EC2 Instance State Change Notification → Karpenter SQS Queue"
        source = ["aws.ec2"]
        detail-type = ["EC2 Instance State-change Notification"]
    }
  }
  
  sqs_queue_arn = module.karpenter_queue.karpenter_sqs_queue_arn
}