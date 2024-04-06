provider "aws" {
    region = "us-east-1"
}

module "web01-module" {
    source = "./Modules"
    instance_type = "t2.micro"
}