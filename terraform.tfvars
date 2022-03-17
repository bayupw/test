vpcs = {
  prod = {
    name            = "prod"
    cidr            = "10.1.0.0/16"
    private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
  }
  non-prod = {
    name            = "non-prod"
    cidr            = "10.2.0.0/16"
    private_subnets = ["10.2.1.0/24", "10.2.2.0/24"]
  }
}    