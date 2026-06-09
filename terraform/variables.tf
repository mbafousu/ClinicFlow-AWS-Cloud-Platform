variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "clinicflow-aws-platform"
}

variable "alert_email" {
  type        = string
  description = "Email address for SNS alerts"
}