resource "aws_vpc" "sample_vpc" {
  cidr_block                       = var.VPC_CIDR # VPCに設定したいCIDRを指定
  enable_dns_support               = "true" # VPC内でDNSによる名前解決を有効化するかを指定
  enable_dns_hostnames             = "true" # VPC内インスタンスがDNSホスト名を取得するかを指定
  instance_tenancy                 = "default" # VPC内インスタンスのテナント属性を指定
  assign_generated_ipv6_cidr_block = "false" # IPv6を有効化するかを指定

  tags = {
    Name  = "sample_vpc_${var.ENV}"
    Env = var.ENV
  }
}

resource "aws_subnet" "sample_subnet_a" {
  vpc_id                          = aws_vpc.sample_vpc.id # VPCのIDを指定
  cidr_block                      = var.SUBNET_A_CIDR # サブネットに設定したいCIDRを指定
  assign_ipv6_address_on_creation = "false" # IPv6を利用するかどうかを指定
  map_public_ip_on_launch         = "true" # VPC内インスタンスにパブリックIPアドレスを付与するかを指定
  availability_zone               = "ap-northeast-1a" # サブネットが稼働するAZを指定

  tags = {
    Name = "sample_subnet_${var.ENV}_1a"
    Env = var.ENV
  }
}

resource "aws_subnet" "sample_subnet_c" {
  vpc_id                          = aws_vpc.sample_vpc.id
  cidr_block                      = var.SUBNET_C_CIDR
  assign_ipv6_address_on_creation = "false"
  map_public_ip_on_launch         = "true"
  availability_zone               = "ap-northeast-1c"

  tags = {
    Name = "sample_subnet_${var.ENV}_1c"
    Env = var.ENV
  }
}


resource "aws_internet_gateway" "sample_igw" {
  vpc_id = aws_vpc.sample_vpc.id # VPCのIDを指定

  tags = {
    Name  = "sample_igw_${var.ENV}"
    Env = var.ENV
  }
}


resource "aws_route_table" "sample_rt" {
  vpc_id = aws_vpc.sample_vpc.id # VPCのIDを指定

  # 外部向け通信を可能にするためのルート設定
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sample_igw.id
  }

  tags = {
    Name  = "sample_rt_${var.ENV}"
    Env = var.ENV
  }
}

resource "aws_main_route_table_association" "sample_rt_vpc" {
  vpc_id         = aws_vpc.sample_vpc.id # 紐づけたいVPCのIDを指定
  route_table_id = aws_route_table.sample_rt.id # 紐付けたいルートテーブルのIDを指定
}

resource "aws_route_table_association" "sample_rt_subet_a" {
  subnet_id      = aws_subnet.sample_subnet_a.id # 紐づけたいサブネットのIDを指定
  route_table_id = aws_route_table.sample_rt.id # 紐付けたいルートテーブルのIDを指定
}

resource "aws_route_table_association" "sample_rt_subnet_c" {
  subnet_id      = aws_subnet.sample_subnet_c.id
  route_table_id = aws_route_table.sample_rt.id
}