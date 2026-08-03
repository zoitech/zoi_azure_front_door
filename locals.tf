locals {
  env_short = {
    production  = "prd"
    development = "dev"
    test        = "tst"
    staging     = "stg"
    uat         = "uat"
    sandbox     = "sbx"
    poc         = "poc"
  }[var.environment]

  _location_short_map = {
    "australiacentral"   = "auc"
    "australiaeast"      = "aue"
    "brazilsouth"        = "brs"
    "canadacentral"      = "cac"
    "centralindia"       = "cin"
    "centralus"          = "cus"
    "eastasia"           = "ea"
    "eastus"             = "eus"
    "eastus2"            = "eus2"
    "francecentral"      = "frc"
    "germanywestcentral" = "gwc"
    "japaneast"          = "jpe"
    "koreacentral"       = "krc"
    "northeurope"        = "neu"
    "southeastasia"      = "sea"
    "swedencentral"      = "sdc"
    "switzerlandnorth"   = "szn"
    "uaenorth"           = "uaen"
    "uksouth"            = "uks"
    "westeurope"         = "weu"
    "westus"             = "wus"
    "westus2"            = "wus2"
    "westus3"            = "wus3"
  }

  location_short = lookup(
    local._location_short_map,
    lower(replace(var.location, " ", "")),
    lower(replace(var.location, " ", ""))
  )

  _suffix_part = var.suffix == null || trimspace(var.suffix) == "" ? "" : "-${var.suffix}"

  profile_name      = coalesce(var.name_override, "afd-${var.workload}-${local.env_short}-${local.location_short}${local._suffix_part}")
  endpoint_name     = coalesce(var.endpoint_name_override, "ep-${var.workload}-${local.env_short}-${local.location_short}${local._suffix_part}")
  origin_group_name = coalesce(var.origin_group_name_override, "og-${var.workload}-${local.env_short}-${local.location_short}${local._suffix_part}")
  origin_name       = coalesce(var.origin_name_override, "org-${var.workload}-${local.env_short}-${local.location_short}${local._suffix_part}")

  _default_tags = {
    managed_by  = "terraform"
    environment = local.env_short
    workload    = var.workload
  }

  tags = merge(local._default_tags, var.tags)
}
