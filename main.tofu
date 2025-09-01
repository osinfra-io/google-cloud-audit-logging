# Datadog Google Cloud Platform Integration Module (osinfra.io)
# https://github.com/osinfra-io/opentofu-datadog-google-integration

module "datadog" {
  source = "github.com/osinfra-io/opentofu-datadog-google-integration?ref=v0.3.6"
  count  = var.datadog_enable ? 1 : 0

  api_key = var.datadog_api_key
  labels  = module.helpers.labels
  project = module.projects["audit01"].id
}

# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/opentofu-google-project

module "projects" {
  source = "github.com/osinfra-io/opentofu-google-project?ref=v0.4.6"

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
    "monitoring.googleapis.com",
    "securitycenter.googleapis.com"
  ]
}

# Project IAM Member Resource
# https://search.opentofu.org/provider/hashicorp/google/latest/docs/resources/google_project_iam_member

resource "google_project_iam_member" "backend_service_account_groups" {
  for_each = toset(
    [
      "audit01"
    ]
  )

  member  = "group:backend-${module.helpers.env}@${var.primary_domain}"
  project = module.projects[each.key].id
  role    = "roles/resourcemanager.projectIamAdmin"
}
