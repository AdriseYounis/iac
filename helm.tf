resource "helm_release" "prometheus" {
  chart      = "prometheus"
  name       = "prometheus"
  namespace  = var.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "15.5.3"

  set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }

  set {
    name  = "server\\.resources"
    value = yamlencode({
      limits   = {
        cpu    = "256m"
        memory = "256Mi"
      }
      requests = {
        cpu    = "256m"
        memory = "256Mi"
      }
    })
  }
}