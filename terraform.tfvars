#Information tenant and subscription
subscription_id                     = "                                 "
tenant_id                           = "                                 "

#Azure Active Directory Domain Services
azuread_service_principal           = "2565bd9d-da50-47d4-8b85-4c97f669dc36"
microsoftaad_provider_registration  = "Microsoft.AAD"
ad_rg                               = "aadds-rg"
location                            = "eastus"
domain_name                         = "demo.test"
domain_user_upn                     = "admin@demo.test"             
domain_password                     = "ChangeMe123!"
vnet_aadds                          = "192.168.0.0/16"
subnet_aadds                        = "192.168.1.0/24"
dns_servers                         = ["192.168.1.4","192.168.1.5"]
sku_aadds                           = "Standard"
tags                                = "Prod"
notification_email = [
    "demo_user1@gmail.com",
    "demo_user2@gmail.com"
  ]


  