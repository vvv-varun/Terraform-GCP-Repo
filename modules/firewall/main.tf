resource "google_compute_firewall" "allow_hc" {
  name        = "hc-firewall"
  network     = var.network_source
  target_tags = var.target_tags
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}

resource "google_compute_firewall" "allow_egress" {
  name        = "egress-firewall"
  network     = var.network_source
  target_tags = var.target_tags
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }
  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name        = "iap-ssh-firewall"
  network     = var.network_source
  target_tags = var.target_tags
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
}