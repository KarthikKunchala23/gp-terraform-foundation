variable "team" {
  type = string
  default = null
}

variable "env" {
  type = string
  default = null
}

variable "vpc_id" {
  description = "vpc id for sg"
  type = string
  default = null
}