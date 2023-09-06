data "aws_ami" "demo_ser" {
  
  filter {
			    name   = "image-id"
			    # values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
				values = ["ami-0453898e98046c639"]
			  }
 
 filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

 owners = ["137112412989"]
}