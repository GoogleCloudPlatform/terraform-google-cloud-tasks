# terraform-google-cloud-tasks

## Description
This module makes it easy to create Google Cloud Tasks, which is a fully managed regionalized service that allows you to manage the execution, dispatch and delivery of a large number of distributed tasks.

## Usage

Basic usage of this module is as follows:

```hcl
module "cloud_tasks" {
  source  = "terraform-google-modules/cloud-tasks/google"
  version = "~> 0.4"

  project_id  = "<PROJECT ID>"
  bucket_name = "gcs-test-bucket"
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_engine\_routing\_override | Overrides for task-level appEngineRouting and these settings apply only to App Engine tasks in the queue structure | <pre>object({<br>    service  = optional(string)<br>    version  = optional(string)<br>    instance = optional(string)<br>    host     = optional(string)<br>  })</pre> | `null` | no |
| http\_target | Modifies HTTP target for HTTP tasks | <pre>object({<br>    uri_override = object({<br>      scheme = optional(string)<br>      host   = optional(string)<br>      port   = optional(string)<br>      path_override = object({<br>        path = optional(string)<br>      })<br>      query_override = object({<br>        query_params = optional(string)<br>      })<br>      uri_override_enforce_mode = optional(string)<br>    })<br>    http_method = optional(string)<br>    oath_token = optional(object({<br>      service_account_email = string<br>      scope                 = optional(string)<br>    }))<br>    oidc_token = optional(object({<br>      service_account_email = string<br>      audience              = optional(string)<br>    }))<br>  })</pre> | `null` | no |
| location | The location of the queue | `string` | n/a | yes |
| member | Identities that will be granted the privilege in role, must be passed when iam\_choice is iam\_member | `string` | `null` | no |
| members | Identities that will be granted the privilege in role, must be passed when iam\_choice is iam\_binding or iam\_policy | `list(string)` | `[]` | no |
| project\_id | The ID of the project in which the resource belongs | `string` | n/a | yes |
| queue\_iam\_choice | Opt 1. iam\_binding, 2. iam\_member, 3. iam\_policy, 4. iam\_member\_binding (for both iam\_member and iam\_binding) | `string` | `null` | no |
| queue\_name | The queue name | `string` | n/a | yes |
| rate\_limits | Rate limits for task dispatches | <pre>object({<br>    max_dispatches_per_second = optional(number)<br>    max_concurrent_dispatches = optional(number)<br>    max_burst_size            = optional(number)<br>  })</pre> | `null` | no |
| retry\_config | Settings that determine the retry behavior | <pre>object({<br>    max_attempts       = optional(number)<br>    max_retry_duration = optional(string)<br>    min_backoff        = optional(string)<br>    max_backoff        = optional(string)<br>    max_doublings      = optional(number)<br>  })</pre> | `null` | no |
| role | The role that should be applied, must be passed when a iam\_choice is not null | `string` | `null` | no |
| stackdriver\_logging\_config | Configuration options for writing logs to Stackdriver Logging | <pre>object({<br>    sampling_ratio = optional(number)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| etag | The etag of the IAM policy |
| id | An identifier for the resource with format projects/{{project}}/locations/{{location}}/queues/{{name}} |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Storage Admin: `roles/storage.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
