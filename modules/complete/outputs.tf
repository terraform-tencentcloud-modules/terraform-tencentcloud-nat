output "nat_gateway_id" {
  value = local.nat_gateway_id
}

output "nat_route_ids" {
  value = {
    for k, route in tencentcloud_route_table_entry.route_entry: k => route.route_item_id
  }
}