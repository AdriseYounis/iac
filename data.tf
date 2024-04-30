data "civo_kubernetes_cluster" "my-cluster" {
    name = "payserveglobal-dev-civo"
}

output "kubernetes_cluster_output" {
  value = data.civo_kubernetes_cluster.my-cluster.master_ip
}