# Changelog

All notable changes to this module will be documented in this file.

## [0.2.0](https://github.com/zoi-enavarro/zoi_azure_front_door/compare/v0.1.0...v0.2.0) (2026-08-06)


### Features

* add support for optional custom domain configuration ([#4](https://github.com/zoi-enavarro/zoi_azure_front_door/issues/4)) ([ea5a190](https://github.com/zoi-enavarro/zoi_azure_front_door/commit/ea5a190c4dae3975675a8e2c92e02224fc5434fb))

## 0.1.0 (2026-08-04)


### Features

* pin terraform version to 1.5.7 ([dc271dc](https://github.com/zoi-enavarro/zoi_azure_front_door/commit/dc271dc619612b88a2296cefc9c07fad01b70fb2))
* restrict terraform version to max 1.5.7 ([d852543](https://github.com/zoi-enavarro/zoi_azure_front_door/commit/d852543f1b0fee7b459461923126a58126615bbb))
* update terraform version and enhance module ([f1eabd4](https://github.com/zoi-enavarro/zoi_azure_front_door/commit/f1eabd40bdfbe54afa8089f5dcc2fee5c0ea6bde))
* update terraform version and enhance module ([e13c074](https://github.com/zoi-enavarro/zoi_azure_front_door/commit/e13c07461fe74f5d09e9ea6ebe34e138c1ecc237))

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
