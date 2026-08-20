# Changelog

All notable changes to this module will be documented in this file.

## [1.0.0] - 2026-08-11

INITIAL RELEASE

- Deploys Azure Front Door (CDN profile) with configurable Premium or Standard SKU
- Provisions endpoints, origin groups, and origins with configurable health probe and load balancing settings
- Configures routing rules with HTTPS redirect and optional WAF security policy association
- Supports flexible naming with optional suffix and full name override capabilities
- Enforces Azure-bounds input validation for all numeric and string configuration parameters