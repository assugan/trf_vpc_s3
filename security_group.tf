
###   Create Security Group   ###
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags, { Name = "Private Security Group" })

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "-1"
      security_groups = ["${aws_security_group.public_sg.id}"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags, { Name = "Public Security Group" })

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["${var.ingress_cidr_pub}"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
