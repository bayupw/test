# ---------------------------------------------------------------------------------------------------------------------
# CIDR
# ---------------------------------------------------------------------------------------------------------------------
variable "global_supernet" {
  type    = string
  default = "10.0.0.0/8"
}

# Subnetting
locals {
  aws_supernet   = cidrsubnet(var.global_supernet, 8, 1) # 10.1.0.0/16
  azure_supernet = cidrsubnet(var.global_supernet, 8, 2) # 10.2.0.0/16
  gcp_supernet   = cidrsubnet(var.global_supernet, 8, 3) # 10.3.0.0/16
}

# ---------------------------------------------------------------------------------------------------------------------
# CSP Accounts
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_account" {
  type        = string
  description = "AWS access account"
}

/* variable "azure_account" {
  type        = string
  description = "Azure access account"
}

variable "gcp_account" {
  type        = string
  description = "GCP access account"
} */

# ---------------------------------------------------------------------------------------------------------------------
# CSP Regions
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_region" {
  type        = string
  default     = "ap-southeast-2"
  description = "AWS region"
}

variable "azure_region" {
  type        = string
  default     = "Australia East"
  description = "Azure region"
}

variable "gcp_region" {
  type        = string
  default     = "australia-southeast1"
  description = "GCP region"
}

# ---------------------------------------------------------------------------------------------------------------------
# Aviatrix Transit & Spoke Gateway Size
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_instance_size" {
  type        = string
  default     = "t2.micro" #hpe "c5.xlarge"
  description = "AWS gateway instance size"
}

variable "azure_instance_size" {
  type        = string
  default     = "Standard_B1ms" #hpe "Standard_D3_v2"
  description = "Azure gateway instance size"
}

variable "gcp_instance_size" {
  type        = string
  default     = "n1-standard-1" #hpe "n1-highcpu-4"
  description = "GCP gateway instance size"
}

# ---------------------------------------------------------------------------------------------------------------------
# Aviatrix Gateway Options
# ---------------------------------------------------------------------------------------------------------------------
variable "hpe" {
  type        = bool
  default     = false
  description = "Insane mode"
}

variable "ha_gw" {
  type        = bool
  default     = false
  description = "Enable HA gateway"
}

variable "enable_segmentation" {
  type        = bool
  default     = false
  description = "Enable segmentation"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS EC2
# ---------------------------------------------------------------------------------------------------------------------

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "amzn2-ami-hvm*"
}

variable "key_name" {
  type        = string
  default     = "ec2_keypair"
  description = "Existing SSH public key name"
}

variable "vm_admin_password" {
  type        = string
  default     = "Aviatrix123#"
  description = "Firewall admin password"
}

variable "ingress_ip" {
  type        = string
  default     = "0.0.0.0/0"
  description = "Ingress CIDR block for EC2 Security Group"
}


locals {

  rfc1918             = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  ingress_cidr_blocks = concat(local.rfc1918, [var.ingress_ip])

  # Production Fortigate Firewall bootstrap config
  fg_init_conf = <<EOF
config system admin
    edit admin
        set password ${var.vm_admin_password}
end
config system global
    set hostname fg
    set timezone 04
end
config system interface
    edit port2
    set allowaccess ping https
end
config router static
    edit 1
        set dst 10.0.0.0 255.0.0.0
        set gateway ${cidrhost(module.transit_firenet_1.transit_gateway.lan_interface_cidr, 1)}
        set device port2
    next
    edit 2
        set dst 172.16.0.0 255.240.0.0
        set gateway ${cidrhost(module.transit_firenet_1.transit_gateway.lan_interface_cidr, 1)}
        set device port2
    next
    edit 3
        set dst 192.168.0.0 255.255.0.0
        set gateway ${cidrhost(module.transit_firenet_1.transit_gateway.lan_interface_cidr, 1)}
        set device port2
    next
end
config firewall policy
    edit 1
        set name allow-all-LAN-to-LAN
        set srcintf port2
        set dstintf port2
        set srcaddr all
        set dstaddr all
        set action accept
        set schedule always
        set service ALL
        set logtraffic all
        set logtraffic-start enable
    next
end
EOF
}