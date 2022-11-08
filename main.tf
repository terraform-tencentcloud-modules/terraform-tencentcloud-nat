provider "tencentcloud" {
  region = var.region
}

resource "tencentcloud_nat_gateway" "nat" {
  name             = var.nat_gateway_name
  vpc_id           = var.vpc_id
  bandwidth        = var.nat_bandwidth
  max_concurrent   = var.nat_max_concurrent
  assigned_eip_set = var.assigned_eip_set

  tags = var.nat_gateway_tags
}
