terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = "1.0.39"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.10.1"
    }

     kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.21.1"
    }
  }

  backend "s3" {
    bucket = "tf-os-state"
    key    = "terraform.tfstate"
    region = "LON1"
    endpoints = {
      s3 = "https://objectstore.lon1.civo.com"
    }
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    use_path_style              = true
    access_key                  = var.access_key_id
    secret_key                  = var.secret_key
    skip_s3_checksum            = true
  }
}

provider "civo" {
  region = "LON1"
  token  = var.civo_token
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  } 
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}