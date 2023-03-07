resource "aws_vpc" "prodvpc" {
 cidr_block = "10.2.0.0/16"
 
 tags = {
   Name = "ProdVPC"
   env = "prod"
 }
}

resource "aws_subnet" "prodsub1" {
  vpc_id = aws_vpc.prodvpc.id
  cidr_block = "10.2.1.0/24"
  availability_zone = var.worker_az
  map_public_ip_on_launch = true

  tags = {
      env = "prod"
  }
}

resource "aws_subnet" "prodsub2" {
  vpc_id = aws_vpc.prodvpc.id
  cidr_block = "10.2.2.0/24"
  availability_zone = var.master_az
  map_public_ip_on_launch = true

  tags = {
      env = "prod"
  }
}

resource "aws_internet_gateway" "prod-gw" {}

resource "aws_internet_gateway_attachment" "prodgw-attach" {
  vpc_id = aws_vpc.prodvpc.id
  internet_gateway_id = aws_internet_gateway.prod-gw.id
}

resource "aws_route_table" "mainroute" {
  vpc_id = aws_vpc.prodvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-gw.id
  }
}

resource "aws_route_table_association" "prod-subnets-route1" {
    route_table_id = aws_route_table.mainroute.id
    subnet_id = aws_subnet.prodsub1.id
}

resource "aws_route_table_association" "prod-subnets-route2" {
    route_table_id = aws_route_table.mainroute.id
    subnet_id = aws_subnet.prodsub2.id
}
