resource "helm_release" "prometheus" {
  chart      = "prometheus"
  name       = "prometheus"
  namespace  = var.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "15.5.3"

  values = [
    yamlencode({
      podSecurityPolicy = {
        enabled = false
      }
      server            = {
        persistentVolume = {
          enabled = false
        }
        resources        = {
          limits   = {
            cpu    = "256m"
            memory = "256Mi"
          }
          requests = {
            cpu    = "256m"
            memory = "256Mi"
          }
        }
      }
    })
  ]
}