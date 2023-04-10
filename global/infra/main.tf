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
  source = "github.com/osinfra-io/terraform-google-project?ref=v0.1.0"

  # Max of 200 sinks per project, if you need more, create a new project

  for_each = toset(
    [
      "audit01"
    ]
  )

  billing_account = var.billing_account
  cost_center     = "x001"
  description     = each.key
  environment     = var.environment
  folder_id       = var.folder_id

  labels = {
    "environment" = var.environment,
    "description" = "audit",
    "platform"    = "google-cloud-landing-zone"
  }

  prefix = "plt-lz"
}

# Project IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam_member

resource "google_project_iam_member" "terraform_service_account_groups" {
  # checkov:skip=CKV_GCP_49: Check this out in #24

  for_each = toset(
    [
      "audit01"
    ]
  )

  member  = "group:terraform-backend-${var.environment}@${var.primary_domain}"
  project = module.projects[each.key].project_id
  role    = "roles/resourcemanager.projectIamAdmin"
}
