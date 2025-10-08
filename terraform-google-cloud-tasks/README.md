# terraform-google-cloud-tasks

## Description
### Tagline
This is an auto-generated module.

### Detailed
This module was generated from [terraform-google-module-template](https://github.com/terraform-google-modules/terraform-google-module-template/), which by default generates a module that simply creates a GCS bucket. As the module develops, this README should be updated.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a GCS bucket with the provided name

### PreDeploy
To deploy this blueprint you must have an active billing account and billing permissions.

## Architecture
![alt text for diagram](https://www.link-to-architecture-diagram.com)
1. Architecture description step no. 1
2. Architecture description step no. 2
3. Architecture description step no. N

## Documentation
- [Hosting a Static Website](https://cloud.google.com/storage/docs/hosting-static-website)

## Deployment Duration
Configuration: X mins
Deployment: Y mins

## Cost
[Blueprint cost details](https://cloud.google.com/products/calculator?id=02fb0c45-cc29-4567-8cc6-f72ac9024add)

## Usage

Basic usage of this module is as follows:

```hcl
module "cloud_tasks" {
  source  = "terraform-google-modules/cloud-tasks/google"
  version = "~> 0.1"

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
| project\_id | The ID of the project in which the resource belongs to | `string` | n/a | yes |
| queue\_name | The queue name | `string` | n/a | yes |
| iam\_name | Used to find the parent resource to bind the IAM policy to | `string` | n/a | yes |
| location  | The location of the queue | `string` | n/a | yes |
| queue_iam_choice  | Opt the cloud_tasks_queue_iam: 1. iam_binding, 2. iam_member, 3. iam_policy | `number` | n/a | yes |
| role | The role that should be applied | `string` | n/a | yes |
| member | Identities that will be granted the privilege in role | `string` | n/a | yes |
| app_engine_routing_override  | Overrides for task-level appEngineRouting and these settings apply only to App Engine tasks in the queue structure | `object` | n/a | yes |
| rate_limits  | Rate limits for task dispatches | `object` | n/a | yes |
| retry_config  | Settings that determine the retry behavior | `object` | null | no |
| stackdriver_logging_config  | Configuration options for writing logs to Stackdriver Logging | `object` | null | no |
| http_target | Modifies HTTP target for HTTP task| `object` | null | no |
| desired_state | The desired state of the queue is used to pause and resume the queu | `string` | PAUSED | no |
| members | Identities that will be granted the privilege in role | `list(string)` | null | no |

## Outputs

| Name | Description |
|------|-------------|
| id | An identifier for the resource with format projects/{{project}}/locations/{{location}}/queues/{{name}} |
| etag | The etag of the IAM policy when it is passed as an input |

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
