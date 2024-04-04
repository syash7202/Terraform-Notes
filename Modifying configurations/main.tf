provider "aws" {
  region = "us-east-1"
}


# Attributes 
# -------------------STARTS------------------------
# # creates an sg 
# resource "aws_security_group" "web01-sg" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"

#   tags = {
#     Name = "web01-sg"
#   }
# }

# # creates an sg-inbound-rule
# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#   security_group_id = aws_security_group.web01-sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }



# # creates an ec2 insatnce with using created sg resource
# resource "aws_instance" "web01" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = "t2.micro"
#   security_groups = [aws_security_group.web01-sg.name]
# #                   <RESOURCE_TYPE>.<NAME>.<ATTRIBUTE>

#   tags = {
#     Name = "Cross Refrencing Attributes"
#   }
# }

# -------------------ENDS------------------------

# Ouput Value 
# -------------------STARTS------------------------
# # creates an sg 
# resource "aws_security_group" "web01-sg" {
#   name        = "SSH traffic allow"
#   description = "Allow SSH inbound traffic"

#   tags = {
#     Name = "web01-sg"
#   }
# }

# # creates an sg-inbound-rule
# resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
#   security_group_id = aws_security_group.web01-sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
# }

# #Ouput value

# output "sg-attributes" {
#     value = aws_security_group.web01-sg

# }
# output "sg-description" {
#     value = aws_security_group.web01-sg.description

# }

# -------------------ENDS------------------------


# Variable 
# -------------------STARTS------------------------
# # creates an sg 
# resource "aws_security_group" "web01-sg" {
#   name        = "App traffic allow"
#   description = "Allow App inbound traffic"

#   tags = {
#     Name = "web01-sg"
#   }
# }

# # creates an sg-inbound-rule
# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#   security_group_id = aws_security_group.web01-sg.id
#   cidr_ipv4         = var.vpn_addr
#   from_port         = var.app_port
#   ip_protocol       = "tcp"
#   to_port           = var.app_port
# }

# -------------------ENDS------------------------


# Data Type
# -------------------STARTS------------------------
# # creates an ec2 insatnce with sg list from variables
# resource "aws_instance" "web01" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = "t2.micro"
#   security_groups = var.sg

#   tags = {
#     Name = "List Data type"
#   }
# }
# -------------------ENDS------------------------


# Fetching values from list & maps 
# -------------------STARTS------------------------
# # creates an ec2 insatnce with sg list from variables
# resource "aws_instance" "web01" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = var.type["us-east-1"]
#   security_groups = var.sg

#   tags = {
#     Name = var.tag[0]
#   }
# }
# -------------------ENDS------------------------


# Count & Count index
# -------------------STARTS------------------------
# resource "aws_instance" "web01" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = var.type["us-east-1"]
#   security_groups = var.sg
#   count = 3
# # creates 3 instances as aws_instance-[0], aws_instance-[1], aws_instance-[2]

#   tags = {
#     Name = "ec-2_with.${count.index}"
#   }
# }
# -------------------ENDS------------------------


# Conditional expression
# -------------------STARTS------------------------
# resource "aws_instance" "web01" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = var.type["us-east-1"]
#   security_groups = var.sg
#   count = var.condition_test == true ? 1 : 0
# # check for condition variable value if true 1 instance will be created if false no instance will be created
#   tags = {
#     Name = "ec-2"
#   }
# }
# -------------------ENDS------------------------


# Terraform functions
# -------------------STARTS------------------------
# resource "aws_instance" "web01" {
#   ami           = lookup(var.ami,var.region)
#   # have a map as first arguement and key as second, also thrid argument is for default key. searches for given key associated value from map
#   instance_type = var.type["us-east-1"]
#   security_groups = var.sg
#   count = var.condition_test == true ? 1 : 0

#   tags = {
#     Name = element(var.tags,count.index)
#   # have a list as first arguement and index as second, searches for given value associated value in list
#   }
# }
# -------------------ENDS------------------------

# Data source code
# -------------------STARTS------------------------
# data "aws_ami" "app_ami" {
#   most_recent = true
#   owners      = ["amazon"]
#   # owners can be official, self or any other.

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm*"]
#   }
# }

# resource "aws_instance" "web01" {
#   ami             = data.aws_ami.app_ami.id
#   instance_type   = var.type["us-east-1"]
#   security_groups = var.sg

#   tags = {
#     Name = "test"
#   }
# }
# -------------------ENDS------------------------


# Dynamic blocks
# -------------------STARTS------------------------
variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8200, 8201, 8301, 9200, 9600]
}

resource "aws_security_group" "dynamic_sg" {
  name        = "dynamic_sg"
  description = "Ingress for dyanamic block testing"

  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
# -------------------ENDS------------------------