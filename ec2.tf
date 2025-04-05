# resource "aws_instance" "ec2_instance" {
#   count         = 2
#   ami           = "ami-0b74f796d330ab49c"
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.ssh_key.key_name

#   tags = {
#     Name = "Terraform-EC2-Instance-${count.index + 1}"
#   }
# }

# resource "aws_key_pair" "ssh_key" {
#   key_name   = "terraform-key"
#   public_key = file("~/.ssh/MyKeyPair.pub")
# }

# resource "aws_lb" "load_balancer" {
#   name               = "terraform-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = ["sg-0fb8f0e6e4f75f514"]
#   subnets            = ["subnet-0410b5bf848b623f5", "subnet-0af821388060019bc"]
# }

# resource "aws_lb_target_group" "target_group" {
#   name     = "terraform-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = "vpc-043749502f885c860"

#   health_check {
#     path                = "/"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 3
#     unhealthy_threshold = 2
#   }
# }

# resource "aws_lb_target_group_attachment" "attach_instances" {
#   count            = 2
#   target_group_arn = aws_lb_target_group.target_group.arn
#   target_id        = aws_instance.ec2_instance[count.index].id
# }

# resource "aws_lb_listener" "listener" {
#   load_balancer_arn = aws_lb.load_balancer.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.target_group.arn
#   }
# }

# output "instance_ips" {
#   value = aws_instance.ec2_instance[*].public_ip
# }

# output "load_balancer_dns" {
#   value = aws_lb.load_balancer.dns_name
# }