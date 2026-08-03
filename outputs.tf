output "front_door_profile_id" {
  description = "Resource ID of the Front Door profile."
  value       = azurerm_cdn_frontdoor_profile.this.id
}

output "front_door_profile_name" {
  description = "Name of the Front Door profile."
  value       = azurerm_cdn_frontdoor_profile.this.name
}

output "front_door_endpoint_id" {
  description = "Resource ID of the Front Door endpoint."
  value       = azurerm_cdn_frontdoor_endpoint.this.id
}

output "front_door_hostname" {
  description = "Default Azure Front Door hostname (*.azurefd.net) of the endpoint."
  value       = azurerm_cdn_frontdoor_endpoint.this.host_name
}

output "front_door_route_id" {
  description = "Resource ID of the Front Door route."
  value       = azurerm_cdn_frontdoor_route.this.id
}

output "front_door_origin_group_id" {
  description = "Resource ID of the Front Door origin group."
  value       = azurerm_cdn_frontdoor_origin_group.this.id
}

output "front_door_origin_id" {
  description = "Resource ID of the Front Door origin."
  value       = azurerm_cdn_frontdoor_origin.this.id
}
