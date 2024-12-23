terraform {

  # Requiring Providers
  # https://www.terraform.io/language/providers/requirements#requiring-providers

  required_providers {

    # Datadog Provider
    # https://registry.terraform.io/providers/DataDog/datadog/latest/docs

    datadog = {
      source = "datadog/datadog"
    }

    # Google Cloud Platform Provider
    # https://registry.terraform.io/providers/hashicorp/google/latest/docs

    google = {
      source = "hashicorp/google"
    }

    # Random Provider
    # https://registry.terraform.io/providers/hashicorp/random/latest/docs

    random = {
      source = "hashicorp/random"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# Datadog Google Cloud Platform Integration Module (osinfra.io)
# https://github.com/osinfra-io/terraform-datadog-google-integration

module "datadog" {
  source = "github.com/osinfra-io/terraform-datadog-google-integration?ref=v0.3.0"
  count  = var.datadog_enable ? 1 : 0

  api_key                            = var.datadog_api_key
  is_cspm_enabled                    = true
  is_security_command_center_enabled = true
  labels                             = module.helpers.labels
  project                            = module.projects["audit01"].id
}

# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-project

module "projects" {
  source = "github.com/osinfra-io/terraform-google-project?ref=v0.4.5"

  # Max of 200 sinks per project, if you need more, create a new project

  for_each = toset(
    [
      "audit01"
    ]
  )

  billing_account = var.project_billing_account

  # Setting this to true is irreversible, you will need to delete the project to remove it.
  # For testing purposes we are setting it to false so we can destroy the bucket and recreate it if needed.

  cis_2_2_logging_bucket_locked = false
  description                   = each.key
  folder_id                     = var.project_folder_id
  labels                        = module.helpers.labels
  prefix                        = "plt-lz"

  services = [
    "cloudasset.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "monitoring.googleapis.com"
  ]
}

# Project IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam_member

resource "google_project_iam_member" "terraform_service_account_groups" {
  # Ensure roles do not impersonate or manage Service Accounts used at project level
  # checkov:skip=CKV_GCP_49: This is a requirement for Terraform to manage resources
  for_each = toset(
    [
      "audit01"
    ]
  )

  member  = "group:terraform-backend-${module.helpers.env}@${var.primary_domain}"
  project = module.projects[each.key].id
  role    = "roles/resourcemanager.projectIamAdmin"
}
