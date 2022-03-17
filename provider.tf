terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
    /*     aviatrix = {
      source  = "AviatrixSystems/aviatrix"
      version = "2.21.1-6.6.ga"
    } */
  }
}

provider "aws" {
}

/* # Configuration options
provider "aviatrix" {
}
 */