terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "rg-frontdoor-example-dev-gwc"
  location = "germanywestcentral"
}

module "front_door" {
  source = "../../"

  workload            = "mcp"
  environment         = "development"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  suffix              = "001"

  origin_fqdn       = "ca-mcp-dev.gentlewater-abc123.germanywestcentral.azurecontainerapps.io"
  health_probe_path = "/healthz"

  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]
  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true

  tags = {
    owner = "platform-team"
  }
}

output "front_door_hostname" {
  value = module.front_door.front_door_hostname
}
