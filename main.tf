
###   Create VPC   ###

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(var.default_tags, { Name = "main vpc" })
}

###   Create Subnets   ###

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = merge(var.default_tags, { Name = "public subnet ${count.index + 1}" })
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = merge(var.default_tags, { Name = "public subnet ${count.index + 1}" })
}

###   Create Internet Gateway   ###

resource "aws_internet_gateway" "vpc_gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags, { Name = "internet gateway" })
}

###   Create Route Table   ###

resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags, { Name = "route table" })
}

###   Create Internet Access   ###

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.vpc_route_table.id
  destination_cidr_block = var.destination_cidr
  gateway_id             = aws_internet_gateway.vpc_gw.id
}

###    Associate Route Table with the Subnet   ###
resource "aws_route_table_association" "association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.vpc_route_table.id
}

###   Create S3 bucket   ###
resource "aws_s3_bucket" "assugan_vpc_bucket" {
  bucket = var.bucket_name

  tags = merge(var.default_tags, { Name = "aws bucket" })
}

resource "aws_s3_bucket_acl" "assugan_vpc_bucket" {
  bucket = aws_s3_bucket.assugan_vpc_bucket.id
  acl    = "private"
}
