terraform {
  backend "gcs" {
    prefix = "google-cloud-audit-logging"
  }
}
