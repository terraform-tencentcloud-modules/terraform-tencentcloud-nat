variable "region" {
  default = ""
}

#NAT
variable "nat_gateway_name" {
  default = ""
}

variable "vpc_id" {
  default = ""
}

variable "nat_bandwidth" {
  default = 100
}

variable "nat_max_concurrent" {
  default = 1000000
}

variable "assigned_eip_set" {
  type    = list(string)
  default = [""]
}

variable "nat_gateway_tags" {
  type    = map(string)
  default = {}
}
