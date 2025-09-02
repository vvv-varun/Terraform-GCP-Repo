terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.0.1"
    }
  }

  backend "gcs" {
    prefix = "prod/state"
  }
}

provider "google" {
  project = var.project_id
}