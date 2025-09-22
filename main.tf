# infra-terraform/main.tf

# Use a random suffix to avoid global name collisions
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

# NEW: DATA SOURCE to get information about the existing Resource Group
data "azurerm_resource_group" "main" {
  name = var.existing_resource_group_name
}

# Create a Log Analytics Workspace for Azure Monitor and later AKS monitoring
resource "azurerm_log_analytics_workspace" "main" {
  name                = "log-${var.prefix}-${var.environment}-${random_string.suffix.result}"
  location            = data.azurerm_resource_group.main.location # Uses the existing RG's location
  resource_group_name = data.azurerm_resource_group.main.name     # Uses the existing RG's name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.common_tags
}

# Create an Azure Container Registry (ACR)
resource "azurerm_container_registry" "main" {
  name                = "acr${var.prefix}${var.environment}${random_string.suffix.result}" # ACR name must be globally unique and alphanumeric
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  sku                 = "Standard"
  admin_enabled       = false # Use Managed Identity for access, not admin user
  tags                = var.common_tags
}

# Create an Azure Key Vault for secrets
resource "azurerm_key_vault" "main" {
  name                        = "kv-${var.prefix}-${var.environment}-${random_string.suffix.result}"
  location                    = data.azurerm_resource_group.main.location
  resource_group_name         = data.azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  tags     = var.common_tags
}

# Data source to access information about the current Azure client config.
# Used for getting the current Tenant ID and Object ID.
data "azurerm_client_config" "current" {
}