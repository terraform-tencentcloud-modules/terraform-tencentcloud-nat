variable "create_nat_gateway" {
  type = bool
  default = true
  description = "whether create nat gateway or use an existed one"
}
variable "nat_gateway_id" {
  type = string
  default = ""
  description = "used when `create_nat_gateway` is false"
}

variable "nat_gateway_name" {
  type = string
  default = ""
  description = "nat gateway name"
}
variable "vpc_id" {
  type = string
  default = ""
  description = "id of vpc where nat gateway created"
}
variable "nat_gateway_bandwidth" {
  type = number
  default = 100
  description = "bandwidth of NAT Gateway"
}
variable "nat_gateway_concurrent" {
  description = "bandwidth of NAT Gateway"
  type        = number
  default     = 1000000
}
variable "nat_public_ips" {
  description = "List of EIPs to be used for `nat_gateway`"
  type        = list(string)
}
variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "routable_attachments" {
  type = map(object({
    route_table_id = string
    destination_cidr = optional(string, "0.0.0.0/0")
  }))
  default = {}
  description = "to which route tables should this nat gateway attach"
}