# # Query xsmall instance size
# data "civo_size" "xsmall" {
#     filter {
#         key = "type"
#         values = ["kubernetes"]
#     }

#     sort {
#         key = "ram"
#         direction = "asc"
#     }
# }

# # Create a firewall
# resource "civo_firewall" "payserveglobal-firewall" {
#     name = "payserveglobal-dev-firewall"
# }

# # Create a firewall rule
# resource "civo_firewall_rule" "kubernetes" {
#     firewall_id = civo_firewall.payserveglobal-firewall.id
#     protocol = "tcp"
#     start_port = "6443"
#     end_port = "6443"
#     cidr = ["0.0.0.0/0"]
#     direction = "ingress"
#     label = "kubernetes-api-server"
#     action = "allow"
# }

# # Create a cluster with k3s
# resource "civo_kubernetes_cluster" "my-cluster" {
#     name = "payserveglobal-dev-civo"
#     firewall_id = civo_firewall.payserveglobal-firewall.id
#     cluster_type = "k3s"
#     pools {
#         label = "front-end" // Optional
#         size = element(data.civo_size.xsmall.sizes, 0).name
#         node_count = 1
#     }
# }