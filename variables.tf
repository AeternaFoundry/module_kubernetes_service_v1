variable "service_v1s" {
  description = <<EOT
Map of service_v1s, attributes below
Required:
    - metadata (block):
        - annotations (optional)
        - generate_name (optional)
        - labels (optional)
        - name (optional)
        - namespace (optional)
    - spec (block):
        - allocate_load_balancer_node_ports (optional)
        - cluster_ip (optional)
        - cluster_ips (optional)
        - external_ips (optional)
        - external_name (optional)
        - external_traffic_policy (optional)
        - health_check_node_port (optional)
        - internal_traffic_policy (optional)
        - ip_families (optional)
        - ip_family_policy (optional)
        - load_balancer_class (optional)
        - load_balancer_ip (optional)
        - load_balancer_source_ranges (optional)
        - port (optional, block):
            - app_protocol (optional)
            - name (optional)
            - node_port (optional)
            - port (required)
            - protocol (optional)
            - target_port (optional)
        - publish_not_ready_addresses (optional)
        - selector (optional)
        - session_affinity (optional)
        - session_affinity_config (optional, block):
            - client_ip (optional, block):
                - timeout_seconds (optional)
        - type (optional)
Optional:
    - wait_for_load_balancer
    - timeouts (block):
        - create (optional)
EOT

  type = map(object({
    wait_for_load_balancer = optional(bool)
    metadata = object({
      annotations   = optional(map(string))
      generate_name = optional(string)
      labels        = optional(map(string))
      name          = optional(string)
      namespace     = optional(string)
    })
    spec = object({
      allocate_load_balancer_node_ports = optional(bool)
      cluster_ip                        = optional(string)
      cluster_ips                       = optional(list(string))
      external_ips                      = optional(set(string))
      external_name                     = optional(string)
      external_traffic_policy           = optional(string)
      health_check_node_port            = optional(number)
      internal_traffic_policy           = optional(string)
      ip_families                       = optional(list(string))
      ip_family_policy                  = optional(string)
      load_balancer_class               = optional(string)
      load_balancer_ip                  = optional(string)
      load_balancer_source_ranges       = optional(set(string))
      port = optional(list(object({
        app_protocol = optional(string)
        name         = optional(string)
        node_port    = optional(number)
        port         = number
        protocol     = optional(string)
        target_port  = optional(string)
      })))
      publish_not_ready_addresses = optional(bool)
      selector                    = optional(map(string))
      session_affinity            = optional(string)
      session_affinity_config = optional(object({
        client_ip = optional(object({
          timeout_seconds = optional(number)
        }))
      }))
      type = optional(string)
    })
    timeouts = optional(object({
      create = optional(string)
    }))
  }))
}

