variable "rg_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "West Europe"
}

variable "storage_name" {
  description = "Storage Account Name"
  type        = string
}

variable "apim_name" {
  description = "API Management Name"
  type        = string
}

variable "publisher_name" {
  description = "Publisher Name for APIM"
  type        = string
}

variable "publisher_email" {
  description = "Publisher Email for APIM"
  type        = string
}

variable "api_name" {
  description = "API Name"
  type        = string
}
