output "api_id" {
  description = "The ID of the created API"
  value       = azurerm_api_management_api.api.id
}

output "operation_id" {
  description = "The ID of the API operation"
  value       = azurerm_api_management_api_operation.operation.operation_id
}
