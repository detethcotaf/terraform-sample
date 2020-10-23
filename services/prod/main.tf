module "samples" {
  source  = "../../modules/"
  
  ENV     = "prod"
  VPC_CIDR = "10.0.0.0/16"
  SUBNET_A_CIDR = "10.0.1.0/24"
  SUBNET_C_CIDR = "10.0.2.0/24"
}
