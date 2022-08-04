data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "ubuntu" {
  key_name   = "ubuntu"
  public_key = file("~/.ssh/GenProd.pub")
}

resource "aws_instance" "IaC_workshop" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name        = aws_key_pair.ubuntu.key_name
  
  vpc_security_group_ids = [ 
    aws_security_group.IaC_genesis_sg.id
  ]
  tags = {
    Name = "IaC_workshop"
  }
}