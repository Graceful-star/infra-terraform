# infra-terraform/variables.tf

variable "prefix" {
  description = "A prefix used for all resources in this example. 3-5 characters, alphanumeric only."
  type        = string
  # Removed the validation block for simplicity
}

variable "location" {
  description = "The Azure Region where all resources should be created. Must match the existing Resource Group's location."
  type        = string
  default     = "westus" # Changed from eastus2 to westus
}

variable "environment" {
  description = "The environment (dev, staging, prod)"
  type        = string
  default     = "prod"
}

# NEW VARIABLE: The name of the existing Resource Group
variable "existing_resource_group_name" {
  description = "The name of the EXISTING Resource Group where resources will be deployed."
  type        = string
  default     = "poc" # Setting your 'poc' RG as the default
}

# Tags to apply to all resources
variable "common_tags" {
  description = "A map of common tags to apply to all resources."
  type        = map(string)
  default = {
    Project     = "aks-sre-capstone"
    ManagedBy   = "terraform"
    Environment = "prod"
  }
}