resource "azurerm_api_management_api" "api" {
  name                = var.api_name
  resource_group_name = var.rg_name
  api_management_name = var.apim_name
  revision            = "1"
}

resource "azurerm_api_management_api_operation" "operation" {
  operation_id        = "delete-operation"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  display_name        = "DELETE Resource"
  method              = "DELETE"
  url_template        = "/resource"
}

resource "azurerm_api_management_api_operation_policy" "policy" {
  api_name            = azurerm_api_management_api_operation.operation.api_name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  operation_id        = azurerm_api_management_api_operation.operation.operation_id

  xml_content = <<XML
<policies>
  <inbound>
    <find-and-replace from="xyz" to="abc" />
  </inbound>
</policies>
XML
}
