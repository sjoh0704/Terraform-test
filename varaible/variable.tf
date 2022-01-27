
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1"]
}

variable "cidr_numeral" {
  type    = number
  default = 0
}

variable "cidr_numeral_public" {
  type    = list(number)
  default = [10]
}

variable "cidr_numeral_private" {
  type    = list(number)
  default = [100]
}

variable "vpc_name" {
  type = string
  default = "seung-test"
}


