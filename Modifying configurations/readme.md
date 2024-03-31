# Terraform Configurations

## Attributes

Each resource created in cloud environment has its own set of attributes. These are the fields in a resource that holds the value which end up in state file.

eg: ec2 instance have arrtibutes like id, public_ip, private_ip, instance_state, etc

### Cross Refrencing Resource Attributes

Terraform allows to use the attributes of a resource to be used in another resource.

Generic Syntax:

```
<RESOURCE_TYPE>.<NAME>.<ATTRIBUTE>
```

## Output Values

Ouput values make the information of the resources created available on the command line to be used by other Terraform configurations.

Generic syntax :

```
output "name" {
    value = <RESOURCE_TYPE>.<NAME>.<ATTRIBUTE>
}
```

Gives value of the specific attribute

```
output "name" {
    value = <RESOURCE_TYPE>.<NAME>
}
```

Gives values of the all the attributes

## Terraform Variables

Variables in terraform allows reuse of static values in easy manner without causing human error.

Generic syntax:

**_variable.tf_**

```
variable "var_name" {
    value = "value"
    description = "description of the declared variable"
}
```

**_main.tf_**

```

resource "res_name" "name" {
    attribute = var.var_name
}
```

Production working:

**_variable.tf_**

```
variable "var_name1" {}
variable "var_name2" {}
variable "var_name3" {}
```

**_\*.tfvars_**

```
var_name1 = "default value of variable"
var_name2 = "default value of variable"
var_name3 = "default value of variable"
```

**_main.tf_**

```

resource "res_name" "name" {
    attribute = var.var_name1
}
```

**If the file name is terrform.tfvars -> terrform apply, <br>
if other, like dev.tfvars or prod.tfvars -> terrform apply -var-file="file_name"**

### Variable Defination Precedence

Values of a single variable can be declared at multiple places, i.e in variables.tf, terraform.tfvars file, enviroment variable and -var or -var-file options

| Priority | Type                                        |
| :------: | :------------------------------------------ |
|    1     | -var or -var-file options in CLI            |
|    2     | \*.auto.tfvars or \*.auto.tfvars.json files |
|    3     | terraform.tfvars.json file                  |
|    4     | terraform.tfvars file                       |
|    5     | envornment variables                        |
