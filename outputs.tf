# infra-terraform/outputs.tf

output "resource_group_name" {
  description = "The name of the existing Resource Group being used."
  value       = data.azurerm_resource_group.main.name
}

output "log_analytics_workspace_id" {
  description = "The ID of the created Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.main.id
  sensitive   = false
}

output "acr_login_server" {
  description = "The login server of the created Azure Container Registry."
  value       = azurerm_container_registry.main.login_server
}

output "acr_name" {
  description = "The name of the created Azure Container Registry."
  value       = azurerm_container_registry.main.name
}

output "key_vault_name" {
  description = "The name of the created Key Vault."
  value       = azurerm_key_vault.main.name
}

output "key_vault_id" {
  description = "The ID of the created Key Vault."
  value       = azurerm_key_vault.main.id
}