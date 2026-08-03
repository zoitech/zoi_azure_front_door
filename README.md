<!-- BEGIN_TF_DOCS -->
# Module Overview

This module provisions Azure Front Door (Standard/Premium) resources for public ingress in front of workloads such as Azure Container Apps.

It creates:
- Front Door profile
- Front Door endpoint (`*.azurefd.net`)
- Origin group with health probe and load-balancing settings
- Single origin
- Single route

## Usage

See [examples/basic](examples/basic) for a minimal working example.

## Notes

- `origin_fqdn` should be the backend host name (for example a Container App ingress FQDN).
- `front_door_hostname` output is the Azure-managed endpoint hostname that can be used as a CNAME target.
- Default route behavior is HTTPS-first with redirect from HTTP enabled.
<!-- END_TF_DOCS -->