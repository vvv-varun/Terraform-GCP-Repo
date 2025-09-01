variable "router_name" {
  description = "Name of router"
  type        = string
  default     = "myrouter"
}

variable "region" {
  type = string
}

variable "network" {
  type = string
}

variable "nat_name" {
  type = string
}