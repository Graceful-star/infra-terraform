# infra-terraform/backend.tf

terraform {
  backend "azurerm" {
    resource_group_name  = "poc"                     # Your existing RG
    storage_account_name = "tfstateaks0"            # <<< REPLACE with the name you just created
    container_name       = "tfstate"                 # The container you just created
    key                  = "prod.terraform.tfstate"  # The state file name
  }
}