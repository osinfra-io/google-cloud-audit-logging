# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  labels = {
    cost-center = "x001"
    env         = var.environment
    repository  = "google-cloud-audit-logging"
    platform    = "google-cloud-landing-zone"
    team        = "platform-google-cloud-landing-zone"
  }
}
