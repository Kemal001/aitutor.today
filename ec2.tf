resource "aws_instance" "ec2_instance" {
  ami           = "ami-0b74f796d330ab49c"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/MyKeyPair.pub")
}

output "instance_ip" {
  value = aws_instance.ec2_instance.public_ip
}