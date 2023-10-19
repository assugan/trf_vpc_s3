resource "aws_instance" "public_instance" {
  count                  = var.instances_count
  ami                    = var.public_instance
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet[*].id
  vpc_security_group_ids = ["${aws_security_group.public_sg.id}"]
  tags = {
    Name = "public_instance ${count.index}"
  }
}

resource "aws_instance" "private_instance" {
  count                  = var.instances_count
  ami                    = var.private_instance
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet[*].id
  vpc_security_group_ids = ["${aws_security_group.private_sg.id}"]
  tags = {
    Name = "private_instance ${count.index}"
  }
}
