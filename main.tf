resource "azurerm_cdn_frontdoor_profile" "this" {
  name                     = local.profile_name
  resource_group_name      = var.resource_group_name
  response_timeout_seconds = var.response_timeout_seconds
  sku_name                 = var.sku_name
  tags                     = local.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                     = local.endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  enabled                  = var.enabled
}

resource "azurerm_cdn_frontdoor_origin_group" "this" {
  name                     = local.origin_group_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  session_affinity_enabled = var.session_affinity_enabled

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = var.restore_traffic_time_minutes

  load_balancing {
    additional_latency_in_milliseconds = var.load_balancing_additional_latency_in_milliseconds
    sample_size                        = var.load_balancing_sample_size
    successful_samples_required        = var.load_balancing_successful_samples_required
  }

  health_probe {
    interval_in_seconds = var.health_probe_interval_in_seconds
    path                = var.health_probe_path
    protocol            = var.health_probe_protocol
    request_type        = var.health_probe_request_type
  }
}

resource "azurerm_cdn_frontdoor_origin" "this" {
  name                          = local.origin_name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id

  enabled                        = var.enabled
  host_name                      = var.origin_fqdn
  origin_host_header             = coalesce(var.origin_host_header, var.origin_fqdn)
  http_port                      = var.origin_http_port
  https_port                     = var.origin_https_port
  priority                       = var.origin_priority
  weight                         = var.origin_weight
  certificate_name_check_enabled = var.certificate_name_check_enabled
}

resource "azurerm_cdn_frontdoor_route" "this" {
  name                          = var.route_name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.this.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.this.id]

  enabled                = var.enabled
  forwarding_protocol    = var.forwarding_protocol
  https_redirect_enabled = var.https_redirect_enabled
  link_to_default_domain = var.link_to_default_domain
  patterns_to_match      = var.patterns_to_match
  supported_protocols    = var.supported_protocols

  cdn_frontdoor_custom_domain_ids = local.custom_domain != null ? [azurerm_cdn_frontdoor_custom_domain.this[0].id] : []

  cdn_frontdoor_rule_set_ids = length(var.disable_cache_for_paths) > 0 ? [
    azurerm_cdn_frontdoor_rule_set.disable_cache[0].id
  ] : []
}

# Provision Custom Domain & Azure-Managed SSL Certificate
resource "azurerm_cdn_frontdoor_custom_domain" "this" {
  count                    = local.custom_domain != null ? 1 : 0
  name                     = local.custom_domain_resource_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  host_name                = local.custom_domain.host_name
  dns_zone_id              = local.custom_domain.dns_zone_id

  tls {
    certificate_type = "ManagedCertificate"
  }
}

# Explicit Association Resource (Prevents Lifecycle Drift)
resource "azurerm_cdn_frontdoor_custom_domain_association" "this" {
  count                          = local.custom_domain != null ? 1 : 0
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.this[0].id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.this.id]
}

# Optional: Disable caching for specified paths (useful for SSE, streaming endpoints)
resource "azurerm_cdn_frontdoor_rule_set" "disable_cache" {
  count                    = length(var.disable_cache_for_paths) > 0 ? 1 : 0
  name                     = local.rule_set_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
}

resource "azurerm_cdn_frontdoor_rule" "disable_cache_control" {
  count                     = length(var.disable_cache_for_paths) > 0 ? 1 : 0
  name                      = "disablecachecontrol"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.disable_cache[0].id
  order                     = 1
  behavior_on_match         = "Continue"

  dynamic "conditions" {
    for_each = var.disable_cache_for_paths
    content {
      url_path_condition {
        operator         = "BeginsWith"
        negate_condition = false
        match_values     = [conditions.value]
      }
    }
  }

  actions {
    response_header_action {
      header_action = "Overwrite"
      header_name   = "Cache-Control"
      value         = "no-cache, no-store, no-transform, must-revalidate, private, max-age=0"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "disable_proxy_buffering" {
  count                     = length(var.disable_cache_for_paths) > 0 ? 1 : 0
  name                      = "disableproxybuffering"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.disable_cache[0].id
  order                     = 2
  behavior_on_match         = "Continue"

  dynamic "conditions" {
    for_each = var.disable_cache_for_paths
    content {
      url_path_condition {
        operator         = "BeginsWith"
        negate_condition = false
        match_values     = [conditions.value]
      }
    }
  }

  actions {
    response_header_action {
      header_action = "Append"
      header_name   = "X-Accel-Buffering"
      value         = "no"
    }
  }
}
