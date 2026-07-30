variable "team" {
  description = "Name of the team or tenant of the platform"
  type = string
}

variable "name" {
  description = "Name of the IAM Policy"
  type = string
}

variable "policy" {
  description = "Name of the policy or arn"
  type = string
}

variable "path" {
  description = "Policy path to be define"
  type = string
}

variable "env" {
  description = "environment where policy is creating"
  type = any
}