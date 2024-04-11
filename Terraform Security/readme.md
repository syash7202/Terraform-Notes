# Terraform Security

- To create infrastructure in multiple region `alias` are used to distinguish between configurations

```
# The default provider configuration; resources that begin with `aws_` will use
# it as the default, and it can be referenced as `aws`.
provider "aws" {
  region = "us-east-1"
}

# Additional provider configuration for west coast region; resources can
# reference this as `aws.west`.
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}


resource "<aws_...>" "<name>" {
    provider = aws.west
    # other configurations
}
```

- `sensitive` parameter : this is passed to the resource block to hide the sensitive data like password and secret keys, though these information aren't displayed in output block but can be seen in tfstate files. The sensitive parameter doesn't encrypt the data.
