variable "vpn_addr" {
  default     = "1.4.7.0/32"
  description = "VPN server CIDR value"
}

variable "app_port" {
  default     = "80"
  description = "port for sg-rule"
}

variable "sg" {
  type = list(any)
}

variable "type" {
  type = map(any)
}

variable "tag" {
  type = list(any)
}

variable "condition_test" {
  type = bool

}

variable "region" {
  type = string

}

variable "ami" {
  type = map(any)
}

variable "tags" {
  type = list(any)
}