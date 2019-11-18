resource "azurerm_postgresql_server" "main" {
  name                = "${var.name-suffix}-${var.environment}-${var.region}-${var.random-string}"
  resource_group_name = "${var.resource-group}"
  location            = "${data.azurerm_resource_group.main.location}"

  tags = {
                applicationname         =   "${var.application-name}"
                costcenter              =   "${var.cost-center}"
                deploymenttype          =   "Terraform"
                environmentinfo         =   "${var.environment}"
                notificationdistlist    =   "${var.notificationdistlist}"
                ownerinfo               =   "${var.owner-info}"
                sponsorinfo             =   "${var.sponsor-info}"
            }
  
  sku {
    name     = "${var.sku-name}"
    capacity = "${var.sku-capacity}"
    tier     = "${var.sku-tier}"
    family   = "${var.sku-family}"
  }

  storage_profile {
    storage_mb            = "${var.storage-mb}"
    backup_retention_days = "${var.backup-retention-days}"
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "${var.administrator-login}"
  administrator_login_password = "${var.administrator-password}"
  version                      = "${var.database-version}"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_postgresql_database" "main" {
  name                = "${var.name-suffix}-${var.environment}-${var.region}-${var.random-string}"
  resource_group_name = "${var.resource-group}"
  server_name         = "${azurerm_postgresql_server.main.name}"
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
resource "azurerm_postgresql_virtual_network_rule" "main" {
  name                                 = "${var.name-suffix}-${var.environment}-${var.region}-${var.random-string}"
  resource_group_name                  = "${var.resource-group}"
  server_name                          = "${azurerm_postgresql_server.main.name}"
  subnet_id                            = "${data.azurerm_subnet.main.id}"
  ignore_missing_vnet_service_endpoint = true
}

resource "azurerm_postgresql_firewall_rule" "main" {
  name                = "${var.name-suffix}-${var.environment}-${var.region}-${var.random-string}"
  resource_group_name = "${var.resource-group}"
  server_name         = "${azurerm_postgresql_server.main.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}