output "api_id" {
  description = "The ID of the created API"
  value       = azurerm_api_management_api.api.id
}

output "operation_ids" {
  value = [
    azurerm_api_management_api_operation.get_operation.operation_id,
    azurerm_api_management_api_operation.post_operation.operation_id,
    azurerm_api_management_api_operation.put_operation.operation_id,
    azurerm_api_management_api_operation.delete_operation.operation_id
  ]
}
