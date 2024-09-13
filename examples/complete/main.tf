locals {
  vpc_name = "test-nat-gateway"
  vpc_cidr = "10.0.0.0/16"
  nat_gateway_name = "test-nat-gateway"

  eips = [
    "test-nat-gateway-1",
    "test-nat-gateway-2"
  ]
}

module "vpc" {
  source  = "terraform-tencentcloud-modules/vpc/tencentcloud"
  version = "1.1.0"
  vpc_name = local.vpc_name
  vpc_cidr = local.vpc_cidr
}

resource "tencentcloud_eip" "eips" {
  count                      = length(local.eips)
  name                       = local.eips[count.index]
  internet_max_bandwidth_out = 100
}

module "nat" {
  source = "../../modules/complete"
  nat_gateway_name = local.nat_gateway_name
  vpc_id = module.vpc.vpc_id
  nat_public_ips = tencentcloud_eip.eips.*.public_ip
  nat_product_version = 2
  routable_attachments = {
    default = {
      route_table_id = module.vpc.route_table_id
    }
  }
}