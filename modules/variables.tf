variable ENV {
  type = string
  description = "環境(prod/dev)"
  default = "dev"
}

variable VPC_CIDR {
  type = string
  description = "VPCのCIDR"
  default = "10.1.0.0/16"
}

variable SUBNET_A_CIDR {
  type = string
  description = "subnet aのCIDR"
  default = "10.1.1.0/24"
}

variable SUBNET_C_CIDR {
  type = string
  description = "subnet cのCIDR"
  default = "10.1.2.0/24"
}

variable SG_CIDR {
  type = list(string)
  description = "Security Groupにて通信したいCIDRのリスト"
  default = ["10.1.0.0/16",]
}

variable ACM_ARN {
  type = string
  description = "ACMのARN"
}