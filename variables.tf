variable "key_name" {
  default     = "di_aws"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "availability_zone" {
  type = string
  default = "us-east-1a"
}

variable "tag" {
  default = "aws-training-terraform"
}