resource "aws_instance" "public_instance" {
  count                  = var.public_instance_count
  ami                    = var.public_instance
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.My_VPC_Subnet_Public.id
  vpc_security_group_ids = ["${aws_security_group.My_VPC_Security_Group_Public[count.index]}"]
  tags = {
    Name = "public_instance ${count.index + 1}"
  }
}

resource "aws_instance" "private_instance" {
  count                  = var.private_instance_count
  ami                    = var.private_instance
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.My_VPC_Subnet_Private.id
  vpc_security_group_ids = ["${aws_security_group.My_VPC_Security_Group_Private[count.index]}"]
  tags = {
    Name = "private_instance ${count.index + 1}"
  }
}
