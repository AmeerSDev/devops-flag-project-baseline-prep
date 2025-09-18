terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.1.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.3"
    }
  }
}

# Region VPC (North_Virginia)
provider "aws" {
  alias = "North_Virginia"
  region = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  token = var.aws_session_token
}