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

provider "kubernetes" {
  host     = data.civo_kubernetes_cluster.my-cluster.api_endpoint
  client_certificate = base64decode(
    yamldecode(data.civo_kubernetes_cluster.my-cluster.kubeconfig).users[0].user.client-certificate-data
  )
  client_key = base64decode(
    yamldecode(data.civo_kubernetes_cluster.my-cluster.kubeconfig).users[0].user.client-key-data
  )
  cluster_ca_certificate = base64decode(
    yamldecode(data.civo_kubernetes_cluster.my-cluster.kubeconfig).clusters[0].cluster.certificate-authority-data
  )
}

provider "helm" {
    kubernetes {
      host     = data.civo_kubernetes_cluster.my-cluster.api_endpoint
      client_certificate = base64decode(
        yamldecode(data.civo_kubernetes_cluster.my-cluster.kubeconfig).users[0].user.client-certificate-data
      )
      client_key = base64decode(
        yamldecode(data.civo_kubernetes_cluster.my-cluster.kubeconfig).users[0].user.client-key-data
      )
      cluster_ca_certificate = base64decode(
        yamldecode(data.civo_kubernetes_cluster.my-cluster.kubeconfig).clusters[0].cluster.certificate-authority-data
      )
  }
}