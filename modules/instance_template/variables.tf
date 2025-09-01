variable "machine_type" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "startup_script" {
  type = string
}

variable "network_source" {
  type = string
}

variable "instance_tags" {
  type = list(string)
}