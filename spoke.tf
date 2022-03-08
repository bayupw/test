# ---------------------------------------------------------------------------------------------------------------------
# AWS Transit1 - Spokes
# ---------------------------------------------------------------------------------------------------------------------
module "spoke1_transit1" {
  source        = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  cloud         = "AWS"
  name          = "spoke1"
  cidr          = "10.100.1.0/24"
  region        = var.aws_region
  account       = var.aws_account
  transit_gw    = module.transit_firenet_1.transit_gateway.gw_name
  insane_mode   = var.hpe
  instance_size = var.aws_instance_size
  ha_gw         = var.ha_gw
}

module "spoke2_transit1" {
  source        = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  cloud         = "AWS"
  name          = "spoke2"
  cidr          = "10.100.2.0/24"
  region        = var.aws_region
  account       = var.aws_account
  transit_gw    = module.transit_firenet_1.transit_gateway.gw_name
  insane_mode   = var.hpe
  instance_size = var.aws_instance_size
  ha_gw         = var.ha_gw
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Transit1 - Spokes
# ---------------------------------------------------------------------------------------------------------------------
module "spoke3_transit2" {
  source        = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  cloud         = "AWS"
  name          = "spoke3"
  cidr          = "10.200.1.0/24"
  region        = var.aws_region
  account       = var.aws_account
  transit_gw    = module.transit_firenet_2.transit_gateway.gw_name
  insane_mode   = var.hpe
  instance_size = var.aws_instance_size
  ha_gw         = var.ha_gw
}

module "spoke4_transit2" {
  source        = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  cloud         = "AWS"
  name          = "spoke4"
  cidr          = "10.200.2.0/24"
  region        = var.aws_region
  account       = var.aws_account
  transit_gw    = module.transit_firenet_2.transit_gateway.gw_name
  insane_mode   = var.hpe
  instance_size = var.aws_instance_size
  ha_gw         = var.ha_gw
}