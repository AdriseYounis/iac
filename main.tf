data "civo_size" "xsmall" {
    filter {
        key = "type"
        values = ["kubernetes"]
    }

    sort {
        key = "ram"
        direction = "asc"
    }
}

resource "civo_network" "custom_net" {
  label = "payserveglobal-network"
}

resource "civo_firewall" "www" {
  name       = "payserveglobal-firewall"
  network_id = civo_network.custom_net.id
}

resource "civo_firewall" "payserveglobal_firewall" {
  name                 = "payserveglobal-firewall"
  network_id           = civo_network.custom_net.id
  create_default_rules = false
  
  ingress_rule {
    label      = "k8s"
    protocol   = "tcp"
    port_range = "6443"
    cidr       = ["192.168.1.1/32", "192.168.10.4/32", "192.168.10.10/32"]
    action     = "allow"
  }

  ingress_rule {
    label      = "ssh"
    protocol   = "tcp"
    port_range = "22"
    cidr       = ["192.168.1.1/32", "192.168.10.4/32", "192.168.10.10/32"]
    action     = "allow"
  }

  egress_rule {
    label      = "all"
    protocol   = "tcp"
    port_range = "1-65535"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }
}

resource "civo_kubernetes_cluster" "my-cluster" {
    name = "payserveglobal-dev-civo"
    firewall_id = civo_firewall.payserveglobal_firewall.id
    network_id = civo_network.custom_net.id
    cluster_type = "k3s"
    pools {
        label = "front-end" // Optional
        size = element(data.civo_size.xsmall.sizes, 0).name
        node_count = 1
    }
}