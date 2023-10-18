# create Provider
provider "aws" {
  region = var.region
}

# create VPC
resource "aws_vpc" "My_VPC" {
  cidr_block = var.vpcCIDRblock

  tags = {
    Name = "My VPC"
  }
}


# create Subnets
resource "aws_subnet" "My_VPC_Subnet_Public" {
  #count             = var.subnet_count
  vpc_id            = aws_vpc.My_VPC.id
  cidr_block        = element(var.publicSubnetCIDR[*], count.index)
  availability_zone = element(var.availabilityZone[*], count.index)
  tags = {
    Name = "My VPC Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "My_VPC_Subnet_Private" {
  #count             = var.subnet_count
  vpc_id            = aws_vpc.My_VPC.id
  cidr_block        = element(var.privateSubnetCIDR[*], count.index)
  availability_zone = element(var.availabilityZone[*], count.index)
  tags = {
    Name = "My VPC Private Subnet ${count.index + 1}"
  }
}


# create Security Group
resource "aws_security_group" "My_VPC_Security_Group_Private" {
  vpc_id      = aws_vpc.My_VPC.id
  name        = "My VPC Security Group Private"
  description = "My VPC Security Group Private"
  ingress {
    security_groups = ["${aws_security_group.My_VPC_Security_Group_Public.id}"]
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
    Name = "My VPC Security Group Private"
  }
}

resource "aws_security_group" "My_VPC_Security_Group_Public" {
  vpc_id      = aws_vpc.My_VPC.id
  name        = "My VPC Security Group Public"
  description = "My VPC Security Group Public"
  ingress {
    cidr_blocks = ["${var.ingressCIDRblockPub}"]
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["${var.ingressCIDRblockPub}"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
    Name = "My VPC Security Group Public"
  }
}


# create Internet Gateway
resource "aws_internet_gateway" "My_VPC_GW" {
  vpc_id = aws_vpc.My_VPC.id
  tags = {
    Name = "My VPC Internet Gateway"
  }
}


# create Route Table
resource "aws_route_table" "My_VPC_route_table" {
  vpc_id = aws_vpc.My_VPC.id
  tags = {
    Name = "My VPC Route Table"
  }
}


# create Internet Access
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = aws_route_table.My_VPC_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.My_VPC_GW.id
}


# Associate Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association" {
  subnet_id      = aws_subnet.My_VPC_Subnet_Public.id
  route_table_id = aws_route_table.My_VPC_route_table[count.index].id
}


# create S3 bucket
resource "aws_s3_bucket" "assugan_vpc_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "VPC_EndPoint_test"
  }
}

resource "aws_s3_bucket_acl" "assugan_vpc_bucket" {
  bucket = aws_s3_bucket.assugan_vpc_bucket.id
  acl    = "private"
}
