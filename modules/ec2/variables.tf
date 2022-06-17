
variable "tag" {
  type = string
}

variable "region" {
  type        = string
}

variable "availability_zone" {
  type = string
}

variable "key_name" {
  type = string
}

variable "subnet_id" {
  type = any
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "associate_public_ip_address" {
  type = bool
  default = false
}