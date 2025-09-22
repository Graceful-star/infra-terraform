# infra-terraform/terraform.tfvars

prefix = "aks01" # Example: 3-5 letters/numbers
location = "westus" # Must match the location of your 'poc' Resource Group
environment = "prod"
existing_resource_group_name = "poc" # The name of your existing RG