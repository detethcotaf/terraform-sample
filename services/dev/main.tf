module "samples" {
  source  = "../../modules/"
  
  ENV     = "dev"
  VPC_CIDR = "10.10.0.0/16"
  SUBNET_A_CIDR = "10.10.1.0/24"
  SUBNET_C_CIDR = "10.10.2.0/24"
}
