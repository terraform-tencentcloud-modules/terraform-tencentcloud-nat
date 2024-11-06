locals {
  nat_gateway_id = var.create_nat_gateway ? concat(tencentcloud_nat_gateway.nat.*.id, [""])[0] : var.nat_gateway_id
}


resource "tencentcloud_nat_gateway" "nat" {
  count               = var.create_nat_gateway ? 1 : 0
  name                = var.nat_gateway_name
  vpc_id              = var.vpc_id
  bandwidth           = var.nat_product_version == 2 ? 5000 : var.nat_gateway_bandwidth
  max_concurrent      = var.nat_product_version == 2 ? 2000000 : var.nat_gateway_concurrent
  assigned_eip_set    = var.nat_public_ips
  nat_product_version = var.nat_product_version
  tags                = var.tags
}

resource "tencentcloud_route_table_entry" "route_entry" {
  for_each               = var.routable_attachments
  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.destination_cidr
  next_type              = "NAT"
  next_hub               = local.nat_gateway_id
  lifecycle {
    ignore_changes = [
      disabled // we do not control this toggle here because it will auto managed by other products such as CFW
    ]
  }
}
