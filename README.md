# Google Cloud Platform - Logging

**[GitHub Actions](https://github.com/osinfra-io/google-cloud-logging/actions):**

[![Infracost](https://github.com/osinfra-io/google-cloud-logging/actions/workflows/infracost.yml/badge.svg)](https://github.com/osinfra-io/google-cloud-logging/actions/workflows/infracost.yml) [![Dependabot](https://github.com/osinfra-io/google-cloud-logging/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/google-cloud-logging/actions/workflows/dependabot.yml)

**[Bridgecrew](https://www.bridgecrew.cloud/projects?types=Passed&repository=osinfra-io%2Fgoogle-cloud-logging&branch=main):**

[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/osinfra-io/google-cloud-logging/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=osinfra-io%2Fgoogle-cloud-logging&benchmark=CIS+GCP+V1.1)

Google Cloud services write audit logs that record administrative activities and accesses within your Google Cloud resources. [Audit logs](https://cloud.google.com/logging/docs/audit) help you answer "who did what, where, and when?" within your Google Cloud resources with the same level of transparency as in on-premises environments. Enabling audit logs helps your security, auditing, and compliance entities monitor Google Cloud data and systems for possible vulnerabilities or external data misuse.

## Terraform Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Providers

No providers.

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_logging_projects"></a> [logging_projects](#module_logging_projects) | git@github.com:osinfra-io/terraform-google-project | n/a |

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing_account](#input_billing_account) | The alphanumeric ID of the billing account this project belongs to | `string` | n/a | yes |
| <a name="input_folder_id"></a> [folder_id](#input_folder_id) | The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input_env) | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |

### Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
