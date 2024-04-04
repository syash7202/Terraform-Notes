# Terraform Notes

**IaC Tools** :

- `Infrastructure Orchestration` : focused over the creation of resources from the code, eg: Terraform, Cloudformation
- `Configruration Management` : focused on managing configurations with the resources and have added feature over top to create resources , eg: Ansible, Chef

**Terraform Commands** :

- `init` : initailizes a terraform directory, downloads & install t the required plugins specified in the configuration files.

- `plan` : generates a execution plan, displays what actually will be done

- `apply` : actually create resources as per the execution plan displayed from the terraform plan command

- `destory`: destroy all the resources recreated from the configuration files

  - for specific resource deletion resource name should be specified.

- `refresh`: updates the state files with current state of the resources, deprecated in newer version

- `fmt` : formats the overall Terraform configurations for better readability

- `validate` : primarily checks whether a configuration is syntactically valid; checks for unsupported arrguements, undeclared variables & others

**High Level Concepts** :

- There are 3 types of `providers tiers` are present:
  - Official : maintained by harshicorp
  - Partner : maintained by 3rd-party organizations
  - Community : maintained by Individuals or Organizations

**With use of Partner or community providers, "required_provider" is used to specify plugins and urls**

- `Terraform State files` :

  - these are the files recreated with the init command
  - logs all the activities of the configuration files
  - because of this file TF can detect the changes in the config file and perform only those actions which are new and not those which are already executed before.
  - not only stores info about all the active resources but also there configurations

- `Desired State` : the configuration file is known as the desired state which is Terraforms primary function to achieve

- `Current State` : the actual state of the resources in the cloud environment

The current state might not match with the desired state if any changes to resources are made manaully.
In such cases, when plan or apply commands are executed the Terraform modify the current state to match the desired state.

**Eg**: if a resource is declared with following configurations,

```
resource "aws_instance" "web" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"

}
```

then here no information is given about security groups, so if changed manually and then terraform refresh is executed. Then it will update the state file with the latest changes but plan or apply command not reinforce any changes to infrastructure as the desired state is matching with the current state.

- `Provider Versioning` : provides versioning to the provider plugins and to upgrade the existing version use `terraform init -upgrade`

| version number arrguements | description                      |
| -------------------------- | -------------------------------- |
| \>=1.0                     | greater than or equal to version |
| \<=1.0                     | less than or equal to version    |
| \>=2.0,<=2.30              | any version between 2.0 & 2.30   |
| \~>2.0                     | any version in 2.X range         |

- `Refresh command` : the terraform refresh coomand is not used manually as it can lead to deletion of desired configurations in state file if the infrastructure is changed manually or new configurations are added but not deployed. Moreover, the refresh command is also automatically executed when plan or apply command are executed. <br>
  If the configurations are lost in the state file then they can be restored from the state backup file created with the state file. <br>
  **The refresh command is deprecated in newer version.**

- `Storing credentials securely` : to store the credentials securely particulary for AWS provider, the default location for Linux/Mac to search is

```
$HOME/.aws/credentials
$HOME/.aws/config
```

## Section-wise Notes

1. [Reading, generating & Modifying configurations][]
2. Terraform Provisioner
3. Terraform Modules & Workspaces
4. Terraform State Management
5. Terraform Security
