
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    action = var.tag
  }
}

resource "aws_subnet" "my_subnet_public" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr_public
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  depends_on = [aws_vpc.my_vpc]
  tags = {
    action = var.tag
  }
}

resource "aws_security_group" "my_security_group_public" {
  name        = "allow_tls_public"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id
  depends_on = [aws_vpc.my_vpc]
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    action = var.tag
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }
  depends_on = [aws_vpc.my_vpc, aws_internet_gateway.my_internet_gateway]
  tags = {
    action = var.tag
  }
}

resource "aws_route_table_association" "my_rt_association_public" {
  route_table_id = aws_route_table.my_route_table.id
  subnet_id = aws_subnet.my_subnet_public.id
  depends_on = [aws_route_table.my_route_table, aws_subnet.my_subnet_public]
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  depends_on = [aws_vpc.my_vpc]
  tags   = {
    action = var.tag
  }
}

resource "aws_nat_gateway" "my_nat_gateway" {
  subnet_id = aws_subnet.my_subnet_public.id
  allocation_id =   aws_eip.my_eip.id
  depends_on = [aws_internet_gateway.my_internet_gateway]
  connectivity_type = "public"
  tags   = {
    action = var.tag
  }
}

resource "aws_eip" "my_eip" {
  vpc = true
  tags   = {
    action = var.tag
  }
}
