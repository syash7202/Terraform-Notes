# Terraform Provisioners

Provisioners are used to execute scripts over the local or remote machines as a part of resource creation or destruction.

example: With creation of any ec2 insatance is created, a script is executed to install Nginx web-server

```
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
```

## Types of TF Provisioners

- `local-exec` : are the local provisioner which execute the command on the host machine i.e from where the Terraform commands are executed.

- `remote-exec` : are the remote provisioner which execute the commands over the resource created via ssh connection

- `file` : Uploads files or directories to the remote machine over SSH. Useful for transferring configuration files or scripts to the target machine.

- `creation-time provsioner` : only executed when the resource is being created, not at the time of updatation or any other lifecycle. **If this provisioner fails then resource is marked as tainted**

- `deletion-time provisioner` : only executed at the time of resource deletion

example :

```resource "aws_instance" "Ngnix" {
# ...

  provisioner "remote-exec" {

    when = destroy
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

```

### Provisioner-Failure Behaviour

By default, if the provisioner fails the terraform apply fails.

But the `on_failure` settings can be used to change this.

| Rules Allowed |                                           Description                                           |
| :-----------: | :---------------------------------------------------------------------------------------------: |
|   continue    |                  ignore the error & continue with the creation or destruction                   |
|     fail      | raise an error & stop applying. If this is a creation provisioner, then the resource is tainted |
