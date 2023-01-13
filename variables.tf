
#Variables tenant and subscription
variable "subscription_id" {
    description = "Azure Subscription ID"
    type = string
}
variable "tenant_id" {
    description = "Azure Tenant ID"
    type = string
}
#Variables Azure Active Directory Domain Services
variable "ad_rg" {
    description = "name resource group aadds"
    type = string
}
variable "location" {
  type        = string
  #default     = "eastus"
  description = "The Azure Region in which all resources in this example should be created."
}
variable "microsoftaad_provider_registration" {
  type        = string
  description = "Provider Registration"
  #default = "Microsoft.AAD"
}
variable "azuread_service_principal" {
  type        = string
  description = "azuread service principal "
  #default = "2565bd9d-da50-47d4-8b85-4c97f669dc36"
}
variable "domain_name" {
  type        = string
  #default     = "onlynews.tech"
  description = "Name of the domain to join"
}
variable "domain_user_upn" {
  type        = string
  #default     = "admin@onlynews.tech"                           
  description = "Username for domain join (do not include domain name as this is appended)"
}
variable "domain_password" {
  type        = string
  #default     = "ChangeMe123!"
  description = "Password of the user to authenticate with the domain"
  sensitive   = true
}
variable "vnet_aadds" {
  type        = string
  #default     = ["10.2.0.0/16"]
  description = "Address range for deployment VNet"
}
variable "subnet_aadds" {
  type        = string
  #default     = ["10.2.0.0/24"]
  description = "Address range for session host subnet"
}
variable "sku_aadds" {
  type        = string
  description = "Sku can be Standard, Premium or Enterprise"
  #default = "Standard"
}
variable "tags" {
  type        = string
  description = "tags environment "
}
variable "notification_email" {
  description = "notifications email"
  type= list(string)
  #default = [
  #  "avduser01@contoso.net",
  #  "avduser02@contoso.net"
  #]
}
variable "dns_servers" {
  description = "dns server"
  type= list(string)
}
