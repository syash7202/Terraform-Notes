 resource "aws_instance" "web01" {
   ami           = "ami-080e1f13689e07408"
   instance_type = var.instance_type
   tags = {
     Name = local.tags
   }
 }
 
 locals {
   tags = "test_with_local"
 }