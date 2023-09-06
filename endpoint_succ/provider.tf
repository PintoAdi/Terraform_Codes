terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.12.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "ADD YOUR OWN"
  secret_key = "ADD YOUR OWN"
}

resource "aws_key_pair" "endpoint" {
  key_name   = "endpoint-key"
  public_key = "ADD YOUR OWN"
}
