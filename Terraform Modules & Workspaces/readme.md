# Terraform Modules

Modules are containers for multiple resources that are used together. A module consists of a collection of `.tf` and/or `.tf.json` files kept together in a directory.

Modules are the main way to package and reuse resource configurations with Terraform.

Modules/ec2.tf :

```
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
```

Modules/variable.tf :

```
variable "instance_type" {
    default = "t1.micro"

}
```

project.tf :

```
provider "aws" {
    region = "us-east-1"
}

module "web01-module" {
    source = "./Modules"
    instance_type = "t2.micro"
}
```
