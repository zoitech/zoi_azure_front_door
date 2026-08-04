# Changelog

All notable changes to this module will be documented in this file.

## [Unreleased]

## [1.1.0] - 2026-08-04

### Fixed
- **Critical** — `locals.tf`: `trimspace(var.suffix)` was always evaluated even when
  `var.suffix == null` because Terraform does not short-circuit `||`. Replaced with a
  nested ternary so `trimspace` is only called when `var.suffix` is not null.

### Changed
- `versions.tf`: Relaxed `required_version` from `~> 1.5.7` (only allows `1.5.x`) to
  `>= 1.5.0`, unblocking Terraform 1.6+, 1.7+, 1.8+, 1.9+.
- `variables.tf`: Added Azure-bounds validation for `origin_priority` (1–5),
  `origin_weight` (1–1000), `restore_traffic_time_minutes` (0–50), and
  `health_probe_interval_in_seconds` (5–31536000).
- `variables.tf`: Added format validation for `suffix` (lowercase alphanumeric and
  hyphens, max 10 chars), `origin_fqdn` (valid hostname), and `route_name`
  (alphanumeric and hyphens, max 90 chars).
- `variables.tf`: Improved descriptions to include accepted ranges for all bounded
  numeric inputs.
- `docs/.terraform-docs.header.md`: Replaced generic placeholder description with an
  accurate module summary.
- `examples/basic/main.tf`: Added a second example (`front_door_no_suffix`) that omits
  `suffix` entirely, exercising the null-default path that previously triggered the bug.
- CI `terraform-ci.yml`: Updated pinned `terraform_version` to match the new minimum
  constraint (`1.5.7` → `1.9.8`).

## [1.0.0] - Initial release

### Added
- Initial hardening baseline.
