variable "vpn_addr" {
  default = "1.4.7.0/32"
  description = "VPN server CIDR value"
}

variable "app_port" {
  default = "80"
  description = "port for sg-rule"
}

variable "sg" {
    type = list
}

variable "type" {
    type = map
}

variable "tag" {
  type = list
}

variable "condition_test" {
  type = bool
  
}