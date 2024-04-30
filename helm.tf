resource "helm_release" "prometheus" {
  name             = "prom"
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  namespace        = "monitoring"
  version          = "17.1.3"
  create_namespace = true
  wait             = true
  reset_values     = true
  max_history      = 3
}

resource "helm_release" "nginx" {
  name        = "nginx"
  chart       = "nginx"
  repository  = "./charts"
  namespace   = "nginx"
  max_history = 3
  create_namespace = true
  wait             = true
  reset_values     = true
}