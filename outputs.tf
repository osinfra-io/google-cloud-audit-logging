# Output Values
# https://www.terraform.io/language/values/outputs

output "project_ids" {
  description = "The project IDs"
  value       = { for k, v in module.projects : k => v.id }
}

output "project_numbers" {
  description = "The project numbers"
  value       = { for k, v in module.projects : k => v.number }
}
