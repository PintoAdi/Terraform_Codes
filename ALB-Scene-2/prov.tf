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
  access_key = "ENTER YOUR OWN"
  secret_key = "ENTER YOUR OWN"

resource "aws_key_pair" "albkey" {
  key_name   = "alb-2-key"
  public_key = "ENTER YOUR OWN"
}
