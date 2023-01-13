# Requeriments for Azure Active Directory Domain Services

# Service Principal for Domain Controller Services published application
# Check readme, item 5
resource "azuread_service_principal" "aadds" {
  application_id = var.azuread_service_principal // published app for domain services
}
# Microsoft.AAD Provider Registration
# Check readme, item 6
resource "azurerm_resource_provider_registration" "aadds" {
  name = var.microsoftaad_provider_registration 
}
# Resource Group
resource "azurerm_resource_group" "aadds" {
  name     = var.ad_rg
  location = var.location
}
# AADDS Domain Controller Admin Group and User
resource "azuread_group" "dc_admins" {
  display_name     = "AAD DC Administrators"
  security_enabled = true
}
resource "azuread_user" "admin" {
  user_principal_name = var.domain_user_upn
  display_name        = "DC Administrator" 
  password            = var.domain_password 
}
resource "azuread_group_member" "admin" {
  group_object_id  = azuread_group.dc_admins.object_id
  member_object_id = azuread_user.admin.object_id
}
#AADDS Managed Domain
resource "azurerm_active_directory_domain_service" "aadds" {
  name                = "Azure AD Domain Service"
  location            = azurerm_resource_group.aadds.location
  resource_group_name = azurerm_resource_group.aadds.name

  domain_name           = var.domain_name
  sku                   = var.sku_aadds 
  filtered_sync_enabled = false

  initial_replica_set {
    subnet_id = azurerm_subnet.aadds.id
  }

  notifications {
    additional_recipients = var.notification_email
    notify_dc_admins      = true
    notify_global_admins  = true
  }

  security {
    sync_kerberos_passwords = true
    sync_ntlm_passwords     = true
    sync_on_prem_passwords  = true
  }

  tags = {
    Environment = var.tags
  }

  depends_on = [
    azuread_service_principal.aadds,
    azurerm_resource_provider_registration.aadds,
    azurerm_subnet_network_security_group_association.aadds,
  ]
}