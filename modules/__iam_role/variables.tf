variable "role_name" {
  description = "Name of the IAM Role"
  type = string
}

variable "team" {
  description = "Name of the team"
  type = string
}

variable "assume_role_trust_policy" {
  description = "Assume Role Policy Name"
  type = string
  default = ""
}

variable "policy_arn" {
  description = "List of policy arn to be attached to role"
  type = list(string)
}

variable "env" {
  description = "Environment of the role where deployed"
  type = string
}