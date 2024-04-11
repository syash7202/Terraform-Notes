# Terraform State Management

To resolve the issue of security & enabling collaboration among the team. Generally the .tfstate, .tfvars, .crash-logs aren't commited into the git repository.

Instead the Terraform configurations are commited to central repository while the .tfstate files are commited to central backend.

## Terraform Backend

Backend primarily determines where the Terraform stores the state files.

Available backends:

|          Platform          | Description                                                       |
| :------------------------: | ----------------------------------------------------------------- |
|           Local            | Stores the state file on the local disk.                          |
|           Remote           | State file is stored remotely, accessible via HTTP or HTTPS.      |
|             S3             | Uses an Amazon S3 bucket to store the state file.                 |
|     Azure Blob Storage     | Stores the state file in Azure Blob Storage.                      |
| Google Cloud Storage (GCS) | Uses GCS to store the state file.                                 |
|           Consul           | State file is stored in Consul's key-value store.                 |
|      Terraform Cloud       | A remote backend provided by HashiCorp's Terraform Cloud service. |
| HashiCorp Consul (Legacy)  | Uses Consul's key-value store for state storage (older version).  |

## Terraform Lock File

State lock happen automatically on all the operations that could write state.

A tfstate.lock file is generated and deleted automatically when the lock is removed, it contains the lock id, user id and more details about the action being performed.

**Not all the backend supports state locking.**

- `force-unlock` command is used to manually unlock the state. but it should be used wisely as false implications can cause multiple writes causing corruption of state files.

## Terraform State Commands

| State sub command | Description                                              |
| :---------------: | -------------------------------------------------------- |
|       list        | list resources within a tf state file.                   |
|        mv         | moves item within a tf state                             |
|       pull        | manually downloads & output the state from remote state. |
|       push        | manually uploads the local state file to remote state.   |
|        rm         | removes items from tf state.                             |
|       show        | show attributes of a single resource in the state.       |

## Terraform Import

The import fucntionality allows to managed manually created resources via terraform. The import block generates not only the tfstate files but also the configuration files.

Genric syntax:

```
import {
    to = aws.instance.example
    id = "i-12345"
}

```

Command :
`terrafoorm apply -generate-config-out=myec2.tf`
