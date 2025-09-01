variable "project_id" {
  description = "My GCP Project"
  type        = string
}

variable "region" {
  description = "List of regions, where region[0] will be the primary region"
  type        = list(string)
  default     = ["us-central1", "europe-north1"]
}

variable "env" {
  type    = string
  default = "prod"
}

variable "web_bucket" {
  type = string
}