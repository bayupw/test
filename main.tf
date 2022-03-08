# ---------------------------------------------------------------------------------------------------------------------
# AWS Transit
# ---------------------------------------------------------------------------------------------------------------------
module "transit_firenet_1" {
  source           = "terraform-aviatrix-modules/aws-transit-firenet/aviatrix"
  version          = "5.0.0"
  name             = "transit-firenet1"
  prefix           = false
  suffix           = false
  cidr             = "10.100.0.0/23"
  region           = var.aws_region
  account          = var.aws_account
  firewall_image   = "Fortinet FortiGate Next-Generation Firewall"
  fw_instance_size = "t2.small"
  fw_amount        = 1
  user_data_1      = local.fg_init_conf
  ha_gw            = var.ha_gw
}

/* module "transit_firenet_2" {
  source  = "terraform-aviatrix-modules/aws-transit-firenet/aviatrix"
  version = "5.0.0"
  name = "transit-firenet2"
  prefix = false
  suffix = false
  cidr           = "10.200.0.0/23"
  region         = var.aws_region
  account        = var.aws_account
  firewall_image = "Palo Alto Networks VM-Series Next-Generation Firewall Bundle 1"
  fw_instance_size   = "m5.xlarge"
  fw_amount = 1
  ha_gw = var.ha_gw
  #user_data_1 = local.fg_init_conf
}

# Create an Aviatrix Transit Gateway Peering
resource "aviatrix_transit_gateway_peering" "transit_firenet_peering" {
  transit_gateway_name1                       = module.transit_firenet_1.transit_gateway.gw_name
  transit_gateway_name2                       = module.transit_firenet_2.transit_gateway.gw_name
  #gateway1_excluded_network_cidrs             = ["0.0.0.0/0"]
  #gateway2_excluded_network_cidrs             = ["0.0.0.0/0"]
} */