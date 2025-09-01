resource "google_compute_health_check" "main" {
  name                = "inst-hc"
  check_interval_sec  = 10
  healthy_threshold   = 2
  unhealthy_threshold = 3
  timeout_sec         = 5
  http_health_check {
    port = 80
  }
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_name = "myvpc"
}

module "network" {
  source      = "./modules/network"
  network     = module.vpc.vpc_name
  for_each    = toset(var.region)
  region      = each.key
  router_name = "myrouter-${each.key}"
  nat_name    = "mynat-${each.key}"
}

module "inst_template" {
  source         = "./modules/instance_template"
  name_prefix    = "${var.env}-main-template-"
  instance_tags  = ["${var.env}-web-server"]
  machine_type   = "e2-micro"
  network_source = module.vpc.vpc_self_link
  startup_script = replace(templatefile("./startup_script.tpl", { web_bucket = var.web_bucket }), "\r", "")
}

module "mig" {
  source             = "./modules/mig"
  for_each           = toset(var.region)
  region             = each.key
  name               = "${var.env}-mig-${each.key}"
  base_instance_name = "${var.env}-inst"
  instance_template  = module.inst_template.inst_template_self_link
  autoscale_name     = "${var.env}-autoscale-${each.key}"
  health_check       = google_compute_health_check.main.self_link
}

locals {
  backend_groups = [for m in module.mig : m.instance_group]
}

module "lb" {
  source          = "./modules/load_balancer"
  backend_groups  = local.backend_groups
  dns_domain      = "terraformed.mooo.com"
  health_check_id = google_compute_health_check.main.id
}

module "firewall" {
  source         = "./modules/firewall"
  network_source = module.vpc.vpc_name
  target_tags    = ["${var.env}-web-server"]
}