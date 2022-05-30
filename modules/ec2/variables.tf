
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

variable "s_pub_id" {
  type = any
}

variable "sg_pub_id" {
  type = list(string)
}