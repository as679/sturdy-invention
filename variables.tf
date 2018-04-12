variable "pkey" {}

variable "az" {
  default = "eu-west-2a"
}

variable "centos" {
  default = "ami-c8d7c9ac"
}

variable "key" {
  default = "training-access"
}

variable "servers" {
  default = 2
}

variable "base_ip" {
  default = "172.20.1.1"
}
