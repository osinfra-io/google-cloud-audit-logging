terraform {

  # Requiring Providers
  # https://www.terraform.io/language/providers/requirements#requiring-providers

  required_providers {

    # Google Cloud Platform Provider
    # https://registry.terraform.io/providers/hashicorp/google/latest/docs

    google = {
      source = "hashicorp/google"
    }
  }
}

# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-project

module "projects" {
  source = "github.com/osinfra-io/terraform-google-project"

  # Max of 200 sinks per project, if you need more, create a new project

  for_each = toset(
    [
      "logs01"
    ]
  )

  billing_account = var.billing_account
  cost_center     = "x001"
  env             = var.env
  folder_id       = var.folder_id

  labels = {
    "environment" = var.env,
    "system"      = "logging",
    "team"        = "shared"
  }

  prefix = "shared"
  system = each.key
}

# Project IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam_member

resource "google_project_iam_member" "terraform_service_account_groups" {
  # checkov:skip=CKV_GCP_49: Check this out in #24

  for_each = toset(
    [
      "logs01"
    ]
  )

  member  = "group:${var.terraform_service_account_group}"
  project = module.projects[each.key].project_id
  role    = "roles/resourcemanager.projectIamAdmin"
}
