resource "kubernetes_service_v1" "service_v1s" {
  for_each = var.service_v1s

  wait_for_load_balancer = each.value.wait_for_load_balancer

  metadata {
    annotations   = each.value.metadata.annotations
    generate_name = each.value.metadata.generate_name
    labels        = each.value.metadata.labels
    name          = each.value.metadata.name
    namespace     = each.value.metadata.namespace
  }

  spec {
    allocate_load_balancer_node_ports = each.value.spec.allocate_load_balancer_node_ports
    cluster_ip                        = each.value.spec.cluster_ip
    cluster_ips                       = each.value.spec.cluster_ips
    external_ips                      = each.value.spec.external_ips
    external_name                     = each.value.spec.external_name
    external_traffic_policy           = each.value.spec.external_traffic_policy
    health_check_node_port            = each.value.spec.health_check_node_port
    internal_traffic_policy           = each.value.spec.internal_traffic_policy
    ip_families                       = each.value.spec.ip_families
    ip_family_policy                  = each.value.spec.ip_family_policy
    load_balancer_class               = each.value.spec.load_balancer_class
    load_balancer_ip                  = each.value.spec.load_balancer_ip
    load_balancer_source_ranges       = each.value.spec.load_balancer_source_ranges
    dynamic "port" {
      for_each = each.value.spec.port != null ? each.value.spec.port : []
      content {
        app_protocol = port.value.app_protocol
        name         = port.value.name
        node_port    = port.value.node_port
        port         = port.value.port
        protocol     = port.value.protocol
        target_port  = port.value.target_port
      }
    }
    publish_not_ready_addresses = each.value.spec.publish_not_ready_addresses
    selector                    = each.value.spec.selector
    session_affinity            = each.value.spec.session_affinity
    dynamic "session_affinity_config" {
      for_each = each.value.spec.session_affinity_config != null ? [each.value.spec.session_affinity_config] : []
      content {
        dynamic "client_ip" {
          for_each = session_affinity_config.value.client_ip != null ? [session_affinity_config.value.client_ip] : []
          content {
            timeout_seconds = client_ip.value.timeout_seconds
          }
        }
      }
    }
    type = each.value.spec.type
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
    }
  }
}

