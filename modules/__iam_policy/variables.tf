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
<<<<<<< HEAD
  type = string
=======
  type = list(string)
>>>>>>> cbbb6cea38fe8ada970997e6ec3aa4aa102cb3a6
}

variable "path" {
  description = "Policy path to be define"
  type = string
}

variable "env" {
  description = "environment where policy is creating"
  type = any
}