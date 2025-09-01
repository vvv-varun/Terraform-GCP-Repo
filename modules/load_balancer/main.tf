
resource "google_compute_global_address" "main" {
  name = "web-https-ip"
}

resource "google_compute_backend_service" "main" {
  name                  = "inst-backend"
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [var.health_check_id]
  session_affinity      = "NONE"
  port_name             = "http"

  dynamic "backend" {
    for_each = toset(var.backend_groups)
    content {
      group           = backend.key
      balancing_mode  = "UTILIZATION"
      max_utilization = 0.8
      capacity_scaler = 1.0
    }
  }

}

resource "google_compute_url_map" "main" {
  name            = "url-map"
  default_service = google_compute_backend_service.main.id
}

resource "google_compute_managed_ssl_certificate" "main" {
  name = "ssl-cert"
  type = "MANAGED"

  managed {
    domains = ["${var.dns_domain}"]
  }
}

resource "google_compute_target_https_proxy" "main" {
  name             = "https-proxy"
  url_map          = google_compute_url_map.main.id
  ssl_certificates = [google_compute_managed_ssl_certificate.main.id]
}

resource "google_compute_global_forwarding_rule" "main" {
  name                  = "forwarding-rule"
  load_balancing_scheme = "EXTERNAL"
  target                = google_compute_target_https_proxy.main.id
  port_range            = "443"
  ip_address            = google_compute_global_address.main.address
}

