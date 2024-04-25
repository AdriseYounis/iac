terraform {
    backend "s3" {
        bucket                      = "terraform-state"
        key                         = "terraform.tfstate"
        region                      = "LON1"
        endpoints = {
        s3 = "https://objectstore.lon1.civo.com"
        }
        skip_credentials_validation = true
        use_path_style              = true
  }

  required_providers {
    civo = {
      source = "civo/civo"
      version = "1.0.39"
    }
  }
}

provider "civo" {
  region = "LON1"
  token = var.civo_token
}