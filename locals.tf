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
    "australiacentral2"  = "auc2"
    "australiaeast"      = "aue"
    "australiasoutheast" = "ause"
    "austriaeast"        = "ate"
    "belgiumcentral"     = "bec"
    "brazilsouth"        = "brs"
    "brazilsoutheast"    = "brse"
    "canadacentral"      = "cac"
    "canadaeast"         = "cae"
    "centralindia"       = "cin"
    "centralus"          = "cus"
    "centraluseuap"      = "cuseuap"
    "chilecentral"       = "clc"
    "chinaeast"          = "cne"
    "chinaeast2"         = "cne2"
    "chinaeast3"         = "cne3"
    "chinanorth"         = "cnn"
    "chinanorth2"        = "cnn2"
    "chinanorth3"        = "cnn3"
    "denmarkeast"        = "dke"
    "eastasia"           = "ea"
    "eastus"             = "eus"
    "eastus2"            = "eus2"
    "eastus2euap"        = "eus2euap"
    "francecentral"      = "frc"
    "francesouth"        = "frs"
    "germanynorth"       = "gn"
    "germanywestcentral" = "gwc"
    "indonesiacentral"   = "idc"
    "indiasouthcentral"  = "scin"
    "israelcentral"      = "ilc"
    "italynorth"         = "itn"
    "jioindiacentral"    = "jic"
    "jioindiawest"       = "jiw"
    "japaneast"          = "jpe"
    "japanwest"          = "jpw"
    "koreacentral"       = "krc"
    "koreasouth"         = "krs"
    "malaysiasouth"      = "mys"
    "malaysiawest"       = "myw"
    "mexicocentral"      = "mxc"
    "newzealandnorth"    = "nzn"
    "northcentralus"     = "ncus"
    "northeurope"        = "neu"
    "norwayeast"         = "noe"
    "norwaywest"         = "now"
    "polandcentral"      = "plc"
    "qatarcentral"       = "qac"
    "southafricanorth"   = "san"
    "southafricawest"    = "saw"
    "southcentralus"     = "scus"
    "southindia"         = "sin"
    "southeastasia"      = "sea"
    "southeastus"        = "seus"
    "spaincentral"       = "spc"
    "swedencentral"      = "sdc"
    "swedensouth"        = "sds"
    "switzerlandnorth"   = "szn"
    "switzerlandwest"    = "szw"
    "taiwannorth"        = "twn"
    "taiwannorthwest"    = "twnw"
    "uaecentral"         = "uaec"
    "uaenorth"           = "uaen"
    "uksouth"            = "uks"
    "ukwest"             = "ukw"
    "usdodcentral"       = "usdc"
    "usdodeast"          = "usde"
    "usgovarizona"       = "usga"
    "usgoviowa"          = "usgi"
    "usgovtexas"         = "usgt"
    "usgovvirginia"      = "usgv"
    "westcentralus"      = "wcus"
    "westeurope"         = "weu"
    "westindia"          = "win"
    "westus"             = "wus"
    "westus2"            = "wus2"
    "westus3"            = "wus3"
  }

  location_short = lookup(
    local._location_short_map,
    lower(replace(var.location, " ", "")),
    lower(replace(var.location, " ", ""))
  )

  # Terraform does not short-circuit logical operators, so avoid guarding trimspace() with `||`.
  _suffix_trimmed = var.suffix == null ? "" : trimspace(var.suffix)
  _suffix_part    = local._suffix_trimmed == "" ? "" : "-${local._suffix_trimmed}"

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
