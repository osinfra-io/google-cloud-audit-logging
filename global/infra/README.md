# Terraform Global Infrastructure Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.46.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_projects"></a> [projects](#module\_projects) | github.com/osinfra-io/terraform-google-project | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.terraform_service_account_groups](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The alphanumeric ID of the billing account this project belongs to | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified | `string` | n/a | yes |
| <a name="input_terraform_service_account_group"></a> [terraform\_service\_account\_group](#input\_terraform\_service\_account\_group) | The group email address for the Terraform backend service account | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
