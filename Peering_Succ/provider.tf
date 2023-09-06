terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.12.0"
    }
  }
}

provider "aws" {
  alias      = "virginia"
  region     = "us-east-1"
  access_key = "ADD YOUR OWN"
  secret_key = "ADD YOUR OWN"
}

provider "aws" {
  alias      = "ohio"
  region     = "us-east-2"
  access_key = "ADD YOUR OWN"
  secret_key = "ADD YOUR OWN"
}

provider "aws" {
  alias      = "mumbai"
  region     = "ap-south-1"
  access_key = "ADD YOUR OWN"
  secret_key = "ADD YOUR OWN"
}

  resource "aws_key_pair" "virginia" {
  provider = aws.virginia
  key_name   = "virginia-key"
  public_key = "ADD YOUR OWN"
}


resource "aws_key_pair" "ohio" {
  provider   = aws.ohio
  key_name   = "ohio-key"
  public_key = "ADD YOUR OWN"
}

resource "aws_key_pair" "mumbai" {
  provider = aws.mumbai
  key_name   = "mum-key"
  public_key = "ADD YOUR OWN"
}

resource "aws_internet_gateway" "gwA" {
  provider = aws.virginia
  vpc_id = aws_vpc.A.id

  tags = {
    Name = "IGW-A"
  }
}

resource "aws_internet_gateway" "gwB" {
  provider = aws.ohio
  vpc_id = aws_vpc.B.id

  tags = {
    Name = "IGW-B"
  }
}

resource "aws_internet_gateway" "gwC" {
  provider = aws.mumbai
  vpc_id = aws_vpc.C.id

  tags = {
    Name = "IGW-C"
  }
}
