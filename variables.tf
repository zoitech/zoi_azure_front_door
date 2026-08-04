variable "workload" {
  description = "Name of the workload or application. Used in resource naming and tagging."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]{1,20}$", var.workload))
    error_message = "workload must be lowercase alphanumeric and hyphens only, max 20 characters."
  }
}

variable "environment" {
  description = "Deployment environment. Valid values: production, development, test, staging, uat, sandbox, poc."
  type        = string
  validation {
    condition     = contains(["production", "development", "test", "staging", "uat", "sandbox", "poc"], var.environment)
    error_message = "environment must be one of: production, development, test, staging, uat, sandbox, poc."
  }
}

variable "location" {
  description = "Azure region where Front Door resources are managed from."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the Front Door profile will be deployed."
  type        = string
}

variable "suffix" {
  description = "Optional suffix appended to generated Front Door resource names. Must be lowercase alphanumeric and hyphens only, max 10 characters."
  type        = string
  default     = null
  validation {
    condition     = var.suffix == null || can(regex("^[a-z0-9-]{1,10}$", var.suffix))
    error_message = "suffix must be lowercase alphanumeric and hyphens only, max 10 characters."
  }
}

variable "name_override" {
  description = "Override the auto-generated Front Door profile name."
  type        = string
  default     = null
}

variable "endpoint_name_override" {
  description = "Override the auto-generated Front Door endpoint name."
  type        = string
  default     = null
}

variable "origin_group_name_override" {
  description = "Override the auto-generated Front Door origin group name."
  type        = string
  default     = null
}

variable "origin_name_override" {
  description = "Override the auto-generated Front Door origin name."
  type        = string
  default     = null
}

variable "sku_name" {
  description = "Front Door profile SKU."
  type        = string
  default     = "Standard_AzureFrontDoor"
  validation {
    condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.sku_name)
    error_message = "sku_name must be Standard_AzureFrontDoor or Premium_AzureFrontDoor."
  }
}

variable "enabled" {
  description = "When false, endpoint, origin and route are created in disabled state."
  type        = bool
  default     = true
}

variable "route_name" {
  description = "Name of the Front Door route. Must be 1–90 characters, alphanumeric and hyphens only."
  type        = string
  default     = "default"
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,90}$", var.route_name))
    error_message = "route_name must be 1–90 characters, alphanumeric and hyphens only."
  }
}

variable "patterns_to_match" {
  description = "URL path patterns matched by the route."
  type        = list(string)
  default     = ["/*"]
}

variable "supported_protocols" {
  description = "Protocols accepted by the endpoint route."
  type        = list(string)
  default     = ["Https"]
  validation {
    condition = length(var.supported_protocols) > 0 && alltrue([
      for p in var.supported_protocols : contains(["Http", "Https"], p)
    ])
    error_message = "supported_protocols must include one or both of: Http, Https."
  }
}

variable "forwarding_protocol" {
  description = "Protocol used by Front Door when forwarding traffic to the origin."
  type        = string
  default     = "HttpsOnly"
  validation {
    condition     = contains(["HttpOnly", "HttpsOnly", "MatchRequest"], var.forwarding_protocol)
    error_message = "forwarding_protocol must be one of: HttpOnly, HttpsOnly, MatchRequest."
  }
}

variable "https_redirect_enabled" {
  description = "When true, HTTP requests are redirected to HTTPS."
  type        = bool
  default     = true
}

variable "link_to_default_domain" {
  description = "When true, the route is linked to the default *.azurefd.net endpoint host."
  type        = bool
  default     = true
}

variable "origin_fqdn" {
  description = "FQDN of the backend origin, for example a Container App ingress hostname."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9.-]+[a-zA-Z0-9]$", var.origin_fqdn))
    error_message = "origin_fqdn must be a valid hostname (e.g. myapp.azurecontainerapps.io)."
  }
}

variable "origin_host_header" {
  description = "Optional host header sent to the origin. Defaults to origin_fqdn."
  type        = string
  default     = null
}

variable "origin_http_port" {
  description = "Origin HTTP port."
  type        = number
  default     = 80
}

variable "origin_https_port" {
  description = "Origin HTTPS port."
  type        = number
  default     = 443
}

variable "origin_priority" {
  description = "Priority of the origin in the origin group. Azure accepts 1–5."
  type        = number
  default     = 1
  validation {
    condition     = var.origin_priority >= 1 && var.origin_priority <= 5
    error_message = "origin_priority must be between 1 and 5."
  }
}

variable "origin_weight" {
  description = "Weight of the origin in the origin group. Azure accepts 1–1000."
  type        = number
  default     = 1000
  validation {
    condition     = var.origin_weight >= 1 && var.origin_weight <= 1000
    error_message = "origin_weight must be between 1 and 1000."
  }
}

variable "certificate_name_check_enabled" {
  description = "Enable TLS certificate name checks between Front Door and origin."
  type        = bool
  default     = true
}

variable "session_affinity_enabled" {
  description = "Enable session affinity on the origin group."
  type        = bool
  default     = false
}

variable "restore_traffic_time_minutes" {
  description = "Minutes Front Door waits before fully restoring traffic to a healed origin. Azure accepts 0–50."
  type        = number
  default     = 10
  validation {
    condition     = var.restore_traffic_time_minutes >= 0 && var.restore_traffic_time_minutes <= 50
    error_message = "restore_traffic_time_minutes must be between 0 and 50."
  }
}

variable "load_balancing_additional_latency_in_milliseconds" {
  description = "Additional latency used by Front Door load balancing algorithm."
  type        = number
  default     = 0
}

variable "load_balancing_sample_size" {
  description = "Sample size used by Front Door load balancing algorithm."
  type        = number
  default     = 4
}

variable "load_balancing_successful_samples_required" {
  description = "Successful sample count required by Front Door load balancing algorithm."
  type        = number
  default     = 3
}

variable "health_probe_path" {
  description = "Health probe path for origin checks."
  type        = string
  default     = "/healthz"
}

variable "health_probe_protocol" {
  description = "Protocol used for origin health probing."
  type        = string
  default     = "Https"
  validation {
    condition     = contains(["Http", "Https"], var.health_probe_protocol)
    error_message = "health_probe_protocol must be Http or Https."
  }
}

variable "health_probe_request_type" {
  description = "HTTP method used for origin health probing."
  type        = string
  default     = "GET"
  validation {
    condition     = contains(["GET", "HEAD"], var.health_probe_request_type)
    error_message = "health_probe_request_type must be GET or HEAD."
  }
}

variable "health_probe_interval_in_seconds" {
  description = "Interval in seconds between health probes. Azure accepts 5–31536000."
  type        = number
  default     = 120
  validation {
    condition     = var.health_probe_interval_in_seconds >= 5 && var.health_probe_interval_in_seconds <= 31536000
    error_message = "health_probe_interval_in_seconds must be between 5 and 31536000."
  }
}

variable "tags" {
  description = "Additional tags to apply. Merged with module-managed tags (managed_by, environment, workload)."
  type        = map(string)
  default     = {}
}
