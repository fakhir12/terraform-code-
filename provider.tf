#AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.85.0"
    }
  }
}
# provider "aws" {
#   alias  = "us_west_1"
#   region = "us-west-1"
# }

# provider "aws" {
#   alias  = "us_east_2"
#   region = "us-east-2"
# }

# provider "aws" {
#   alias  = "default"
#   region = "us-east-1" # Default region
# }