resource "azurerm_api_management_api" "api" {
  name                = var.api_name
  resource_group_name = var.rg_name
  api_management_name = var.apim_name
  revision            = "1"
  display_name        = "My API"  # Add this line
  protocols           = ["https"] # Add this line
}


# GET Operation
resource "azurerm_api_management_api_operation" "get_operation" {
  operation_id        = "get-operation"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  display_name        = "GET Resource"
  method              = "GET"
  url_template        = "/resource"
}

# POST Operation
resource "azurerm_api_management_api_operation" "post_operation" {
  operation_id        = "post-operation"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  display_name        = "POST Resource"
  method              = "POST"
  url_template        = "/resource"
}

# PUT Operation (Fix)
resource "azurerm_api_management_api_operation" "put_operation" {
  operation_id        = "put-operation"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  display_name        = "PUT Resource"
  method              = "PUT"
  url_template        = "/resource/{id}"  # ✅ Keep placeholder format

  # ✅ Add template_parameters for ID
  template_parameters {
    name     = "id"
    required = true
    type     = "string"
  }

  # ✅ Include request and response validation
  request {
    query_parameters {
      name     = "id"
      required = true
      type     = "string"
    }
  }
response {
  status_code = 200
      description = "Success"

}

}

# DELETE Operation (Fix)
resource "azurerm_api_management_api_operation" "delete_operation" {
  operation_id        = "delete-operation"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  display_name        = "DELETE Resource"
  method              = "DELETE"
  url_template        = "/resource/{id}"

  # ✅ Add template_parameters for ID
  template_parameters {
    name     = "id"
    required = true
    type     = "string"
  }

  response {
    status_code = 204
    description = "No Content"
  }
}

# Example policy for GET
resource "azurerm_api_management_api_operation_policy" "get_policy" {
  api_name = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  operation_id        = azurerm_api_management_api_operation.get_operation.operation_id

  xml_content = <<XML
<policies>
  <inbound>
    <base />
  </inbound>
  <backend>
    <base />
  </backend>
  <outbound>
    <base />
  </outbound>
</policies>
XML
}

# Example policy for POST
resource "azurerm_api_management_api_operation_policy" "post_policy" {
  api_name = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  operation_id        = azurerm_api_management_api_operation.post_operation.operation_id

  xml_content = <<XML
<policies>
  <inbound>
    <base />
  </inbound>
  <backend>
    <base />
  </backend>
  <outbound>
    <base />
  </outbound>
</policies>
XML
}

# Example policy for PUT
resource "azurerm_api_management_api_operation_policy" "put_policy" {
  api_name = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  operation_id        = azurerm_api_management_api_operation.put_operation.operation_id

  xml_content = <<XML
<policies>
  <inbound>
    <base />
  </inbound>
  <backend>
    <base />
  </backend>
  <outbound>
    <base />
  </outbound>
</policies>
XML
}

# Example policy for DELETE
resource "azurerm_api_management_api_operation_policy" "delete_policy" {
  api_name = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  operation_id        = azurerm_api_management_api_operation.delete_operation.operation_id

  xml_content = <<XML
<policies>
  <inbound>
    <base />
  </inbound>
  <backend>
    <base />
  </backend>
  <outbound>
    <base />
  </outbound>
</policies>
XML
}
