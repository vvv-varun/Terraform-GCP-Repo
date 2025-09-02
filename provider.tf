terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.0.1"
    }
  }

  backend "gcs" {
    #bucket = "vvv-backend"
    prefix = "prod/state"
    #credentials = "mykey.json"
  }
}

provider "google" {
  project = var.project_id
  #credentials = var.gcp_svc_key
}