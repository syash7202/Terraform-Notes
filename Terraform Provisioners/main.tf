provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Ngnix" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  key_name = "terraform-test"
  security_groups = [ "test1" ]

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo ufw allow 'Nginx HTTP'"
    ]

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ubuntu"
      private_key = "${file("./terraform-test.pem")}"
    }

  }

}