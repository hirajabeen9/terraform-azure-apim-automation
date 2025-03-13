# Define API Management API
resource "azurerm_api_management_api" "api" {
  name                = var.api_name
  resource_group_name = var.rg_name
  api_management_name = var.apim_name
  revision            = "1"
  display_name        = "Public API"
  protocols           = ["https"]
  path                = "testapim"   # Base path for your API

  import {
    content_format = "swagger-link-json"
    content_value  = "https://jsonplaceholder.typicode.com/swagger.json" # Public API
  }
}

# Define Backend (JSONPlaceholder)
resource "azurerm_api_management_backend" "public_api" {
  name                = "jsonplaceholder-backend"
  resource_group_name = var.rg_name
  api_management_name = var.apim_name
  protocol            = "http"
  url                 = "https://jsonplaceholder.typicode.com"
}

# GET Operation
resource "azurerm_api_management_api_operation" "get_operation" {
  operation_id        = "get-operation"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  display_name        = "GET Posts"
  method              = "GET"
  url_template        = "/posts"
}

# POST Operation
resource "azurerm_api_management_api_operation" "post_operation" {
  operation_id        = "post-operation"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  display_name        = "Create Post"
  method              = "POST"
  url_template        = "/posts"
}

# PUT Operation (Fix)
resource "azurerm_api_management_api_operation" "put_operation" {
  operation_id        = "put-operation"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  display_name        = "Update Post"
  method              = "PUT"
  url_template        = "/posts/{id}"  # ✅ JSONPlaceholder format

  template_parameter {
    name     = "id"
    required = true
    type     = "string"
  }

  response {
    status_code = 200
    description = "Post Updated"
  }
}

# DELETE Operation (Fix)
resource "azurerm_api_management_api_operation" "delete_operation" {
  operation_id        = "delete-operation"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  display_name        = "Delete Post"
  method              = "DELETE"
  url_template        = "/posts/{id}"  # ✅ Corrected Path

  template_parameter {
    name     = "id"
    required = true
    type     = "string"
  }

  response {
    status_code = 204
    description = "Post Deleted"
  }
}

# Policy Template (Use Same for all)
variable "policy_template" {
  default = <<XML
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

# Apply Policies to Operations
resource "azurerm_api_management_api_operation_policy" "get_policy" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  operation_id        = azurerm_api_management_api_operation.get_operation.operation_id
  xml_content         = var.policy_template
}

resource "azurerm_api_management_api_operation_policy" "post_policy" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  operation_id        = azurerm_api_management_api_operation.post_operation.operation_id
  xml_content         = var.policy_template
}

resource "azurerm_api_management_api_operation_policy" "put_policy" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  operation_id        = azurerm_api_management_api_operation.put_operation.operation_id
  xml_content         = var.policy_template
}

resource "azurerm_api_management_api_operation_policy" "delete_policy" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.rg_name
  operation_id        = azurerm_api_management_api_operation.delete_operation.operation_id
  xml_content         = var.policy_template
}
