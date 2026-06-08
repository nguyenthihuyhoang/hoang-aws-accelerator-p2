resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = { Name = "${var.env}-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"
  tags = { Name = "${var.env}-public-subnet" }
}

# Private Subnet 1 (using the provided private_cidr in AZ a)
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidr
  availability_zone = "${var.region}a"
  tags = { Name = "${var.env}-private-subnet-1" }
}

# Private Subnet 2 (automatically calculated in AZ b to satisfy AWS RDS DB Subnet Group requirement)
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 3) # e.g. 10.0.3.0/24 if vpc_cidr is 10.0.0.0/16
  availability_zone = "${var.region}b"
  tags = { Name = "${var.env}-private-subnet-2" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "${var.env}-igw" }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
