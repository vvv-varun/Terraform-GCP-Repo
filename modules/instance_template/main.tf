resource "google_compute_instance_template" "main" {
  name_prefix  = var.name_prefix
  machine_type = var.machine_type
  tags         = var.instance_tags
  disk {
    source_image = "debian-12-bookworm-v20250812"
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network = var.network_source
  }
  metadata_startup_script = var.startup_script
  lifecycle {
    create_before_destroy = true
  }
  service_account {
    scopes = ["cloud-platform"]
  }
}