variable ENV {
  type = string
  description = "環境(prod/dev)"
  default = "dev"
}

variable VPC_CIDR {
  type = string
  description = "VPCのCIDR"
  default = "10.0.0.0/16"
}

variable SUBNET_A_CIDR {
  type = string
  description = "subnet aのCIDR"
  default = "10.0.1.0/24"
}

variable SUBNET_C_CIDR {
  type = string
  description = "subnet cのCIDR"
  default = "10.0.2.0/24"
}
