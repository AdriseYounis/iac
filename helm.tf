resource "helm_release" "prometheus" {
  name       = "my-prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "15.0.0"
}

resource "helm_release" "nginx" {
  name       = "my-nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  version    = "8.0.1"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}