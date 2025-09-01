resource "google_compute_router" "main" {
  name    = var.router_name
  network = var.network
  region  = var.region
}

resource "google_compute_router_nat" "main" {
  name                               = var.nat_name
  region                             = var.region
  router                             = google_compute_router.main.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"
}
