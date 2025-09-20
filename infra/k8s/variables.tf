variable "namespace" {
  type    = string
  default = "demo"
}

variable "image" {
  type    = string
  default = "ghcr.io/lfgn84/demo-ci-cd/demo-api:latest"
}

variable "replicas" {
  type    = number
  default = 1
}
