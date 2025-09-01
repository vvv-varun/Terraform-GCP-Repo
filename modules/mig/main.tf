resource "google_compute_region_instance_group_manager" "main" {
  name               = var.name
  base_instance_name = var.base_instance_name
  region             = var.region
  version {
    instance_template = var.instance_template
  }
  named_port {
    name = "http"
    port = 80
  }
  auto_healing_policies {
    initial_delay_sec = 300
    health_check      = var.health_check
  }
  update_policy {
    type                         = "PROACTIVE"
    minimal_action               = "REFRESH"
    max_surge_fixed              = 3
    max_unavailable_fixed        = 3
    instance_redistribution_type = "PROACTIVE"
    replacement_method           = "SUBSTITUTE"
  }
}

resource "google_compute_region_autoscaler" "main" {
  name   = var.autoscale_name
  target = google_compute_region_instance_group_manager.main.id
  region = var.region
  autoscaling_policy {
    max_replicas    = 10
    min_replicas    = 0
    cooldown_period = 60
    cpu_utilization {
      predictive_method = "NONE"
      target            = 0.6
    }
  }
}