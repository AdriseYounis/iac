variable "civo_token" { 
    type = string
    default = "token"
}

variable "access_key_id" {
     type = string
     default = "access-key"
}

variable "secret_key" { 
    type = string
    default = "secret-key"
}

variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}

variable "namespace" {
  type    = string
  default = "monitoring"
}