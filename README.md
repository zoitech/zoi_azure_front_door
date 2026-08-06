<!-- BEGIN_TF_DOCS -->
# Module Overview

This module provisions an **Azure Front Door Standard/Premium** profile in front of
a backend origin (e.g. Azure Container Apps). It creates a Front Door profile,
endpoint, origin group with health probe, origin, and route — all configurable
through input variables with safe, production-ready defaults.

## Usage

See [examples/basic](examples/basic) for a minimal working example.

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, <=1.5.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.81.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_cdn_frontdoor_custom_domain.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_custom_domain) | resource |
| [azurerm_cdn_frontdoor_custom_domain_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_custom_domain_association) | resource |
| [azurerm_cdn_frontdoor_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_endpoint) | resource |
| [azurerm_cdn_frontdoor_origin.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_origin) | resource |
| [azurerm_cdn_frontdoor_origin_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_origin_group) | resource |
| [azurerm_cdn_frontdoor_profile.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_profile) | resource |
| [azurerm_cdn_frontdoor_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_certificate_name_check_enabled"></a> [certificate\_name\_check\_enabled](#input\_certificate\_name\_check\_enabled) | Enable TLS certificate name checks between Front Door and origin. | `bool` | `true` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | Optional custom domain configuration. | <pre>object({<br/>    host_name   = string<br/>    dns_zone_id = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | When false, endpoint, origin and route are created in disabled state. | `bool` | `true` | no |
| <a name="input_endpoint_name_override"></a> [endpoint\_name\_override](#input\_endpoint\_name\_override) | Override the auto-generated Front Door endpoint name. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment. Valid values: production, development, test, staging, uat, sandbox, poc. | `string` | n/a | yes |
| <a name="input_forwarding_protocol"></a> [forwarding\_protocol](#input\_forwarding\_protocol) | Protocol used by Front Door when forwarding traffic to the origin. | `string` | `"HttpsOnly"` | no |
| <a name="input_health_probe_interval_in_seconds"></a> [health\_probe\_interval\_in\_seconds](#input\_health\_probe\_interval\_in\_seconds) | Interval in seconds between health probes. Azure accepts 5–31536000. | `number` | `120` | no |
| <a name="input_health_probe_path"></a> [health\_probe\_path](#input\_health\_probe\_path) | Health probe path for origin checks. | `string` | `"/healthz"` | no |
| <a name="input_health_probe_protocol"></a> [health\_probe\_protocol](#input\_health\_probe\_protocol) | Protocol used for origin health probing. | `string` | `"Https"` | no |
| <a name="input_health_probe_request_type"></a> [health\_probe\_request\_type](#input\_health\_probe\_request\_type) | HTTP method used for origin health probing. | `string` | `"GET"` | no |
| <a name="input_https_redirect_enabled"></a> [https\_redirect\_enabled](#input\_https\_redirect\_enabled) | When true, HTTP requests are redirected to HTTPS. | `bool` | `true` | no |
| <a name="input_link_to_default_domain"></a> [link\_to\_default\_domain](#input\_link\_to\_default\_domain) | When true, the route is linked to the default *.azurefd.net endpoint host. | `bool` | `true` | no |
| <a name="input_load_balancing_additional_latency_in_milliseconds"></a> [load\_balancing\_additional\_latency\_in\_milliseconds](#input\_load\_balancing\_additional\_latency\_in\_milliseconds) | Additional latency used by Front Door load balancing algorithm. | `number` | `0` | no |
| <a name="input_load_balancing_sample_size"></a> [load\_balancing\_sample\_size](#input\_load\_balancing\_sample\_size) | Sample size used by Front Door load balancing algorithm. | `number` | `4` | no |
| <a name="input_load_balancing_successful_samples_required"></a> [load\_balancing\_successful\_samples\_required](#input\_load\_balancing\_successful\_samples\_required) | Successful sample count required by Front Door load balancing algorithm. | `number` | `3` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where Front Door resources are managed from. | `string` | n/a | yes |
| <a name="input_name_override"></a> [name\_override](#input\_name\_override) | Override the auto-generated Front Door profile name. | `string` | `null` | no |
| <a name="input_origin_fqdn"></a> [origin\_fqdn](#input\_origin\_fqdn) | FQDN of the backend origin, for example a Container App ingress hostname. | `string` | n/a | yes |
| <a name="input_origin_group_name_override"></a> [origin\_group\_name\_override](#input\_origin\_group\_name\_override) | Override the auto-generated Front Door origin group name. | `string` | `null` | no |
| <a name="input_origin_host_header"></a> [origin\_host\_header](#input\_origin\_host\_header) | Optional host header sent to the origin. Defaults to origin\_fqdn. | `string` | `null` | no |
| <a name="input_origin_http_port"></a> [origin\_http\_port](#input\_origin\_http\_port) | Origin HTTP port. | `number` | `80` | no |
| <a name="input_origin_https_port"></a> [origin\_https\_port](#input\_origin\_https\_port) | Origin HTTPS port. | `number` | `443` | no |
| <a name="input_origin_name_override"></a> [origin\_name\_override](#input\_origin\_name\_override) | Override the auto-generated Front Door origin name. | `string` | `null` | no |
| <a name="input_origin_priority"></a> [origin\_priority](#input\_origin\_priority) | Priority of the origin in the origin group. Azure accepts 1–5. | `number` | `1` | no |
| <a name="input_origin_weight"></a> [origin\_weight](#input\_origin\_weight) | Weight of the origin in the origin group. Azure accepts 1–1000. | `number` | `1000` | no |
| <a name="input_patterns_to_match"></a> [patterns\_to\_match](#input\_patterns\_to\_match) | URL path patterns matched by the route. | `list(string)` | <pre>[<br/>  "/*"<br/>]</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group where the Front Door profile will be deployed. | `string` | n/a | yes |
| <a name="input_restore_traffic_time_minutes"></a> [restore\_traffic\_time\_minutes](#input\_restore\_traffic\_time\_minutes) | Minutes Front Door waits before fully restoring traffic to a healed origin. Azure accepts 0–50. | `number` | `10` | no |
| <a name="input_route_name"></a> [route\_name](#input\_route\_name) | Name of the Front Door route. Must be 1–90 characters, alphanumeric and hyphens only. | `string` | `"default"` | no |
| <a name="input_session_affinity_enabled"></a> [session\_affinity\_enabled](#input\_session\_affinity\_enabled) | Enable session affinity on the origin group. | `bool` | `false` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Front Door profile SKU. | `string` | `"Standard_AzureFrontDoor"` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Optional suffix appended to generated Front Door resource names. Must be lowercase alphanumeric and hyphens only, max 10 characters. | `string` | `null` | no |
| <a name="input_supported_protocols"></a> [supported\_protocols](#input\_supported\_protocols) | Protocols accepted by the endpoint route. | `list(string)` | <pre>[<br/>  "Https"<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply. Merged with module-managed tags (managed\_by, environment, workload). | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | Name of the workload or application. Used in resource naming and tagging. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_front_door_endpoint_id"></a> [front\_door\_endpoint\_id](#output\_front\_door\_endpoint\_id) | Resource ID of the Front Door endpoint. |
| <a name="output_front_door_hostname"></a> [front\_door\_hostname](#output\_front\_door\_hostname) | Default Azure Front Door hostname (*.azurefd.net) of the endpoint. |
| <a name="output_front_door_origin_group_id"></a> [front\_door\_origin\_group\_id](#output\_front\_door\_origin\_group\_id) | Resource ID of the Front Door origin group. |
| <a name="output_front_door_origin_id"></a> [front\_door\_origin\_id](#output\_front\_door\_origin\_id) | Resource ID of the Front Door origin. |
| <a name="output_front_door_profile_id"></a> [front\_door\_profile\_id](#output\_front\_door\_profile\_id) | Resource ID of the Front Door profile. |
| <a name="output_front_door_profile_name"></a> [front\_door\_profile\_name](#output\_front\_door\_profile\_name) | Name of the Front Door profile. |
| <a name="output_front_door_route_id"></a> [front\_door\_route\_id](#output\_front\_door\_route\_id) | Resource ID of the Front Door route. |

## Authors
Module managed by [Zoi](https://github.com/zoitech).

## License
MIT License. See [LICENSE](LICENSE) for full details.
<!-- END_TF_DOCS -->