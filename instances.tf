
###   Create instances   ###

resource "aws_instance" "public_instance" {
  count                  = var.instances_count
  ami                    = var.public_instance
  instance_type          = var.instance_type
  subnet_id              = element(aws_subnet.public_subnet[*].id, count.index)
  vpc_security_group_ids = ["${aws_security_group.public_sg.id}"]

  tags = merge(var.default_tags, { Name = "public_instance ${count.index}" })
}

resource "aws_instance" "private_instance" {
  count                  = var.instances_count
  ami                    = var.private_instance
  instance_type          = var.instance_type
  subnet_id              = element(aws_subnet.private_subnet[*].id, count.index)
  vpc_security_group_ids = ["${aws_security_group.private_sg.id}"]

  tags = merge(var.default_tags, { Name = "privat_instance ${count.index}" })
}
