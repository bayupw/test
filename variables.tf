data "aws_region" "current" {}

variable "vpcs" {
  type = map(any)
}