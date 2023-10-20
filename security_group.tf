# create Security Group
resource "aws_security_group" "private_sg" {
  vpc_id      = aws_vpc.main.id
  name        = "Security Group Private"
  description = "Security Group Private"
  
  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "-1"
      security_groups = ["${aws_security_group.public_sg.id}"]
    }
  }
  dynamic "egress" {
    for_each = var.allow_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "Security Group Private"
  }
}

resource "aws_security_group" "public_sg" {
  vpc_id      = aws_vpc.main.id
  name        = "Security Group Public"
  description = "Security Group Public"

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      cidr_blocks = ["${var.ingress_cidr_pub}"]
    }
  }
  dynamic "egress" {
    for_each = var.allow_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["${var.ingress_cidr_pub}"]
    }
  }
  tags = {
    Name = "Security Group Public"
  }
}



# ["${var.ingress_cidr_pub}"]



/*
  ingress {
    security_groups = ["${aws_security_group.public_sg.id}"]
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
    Name = "Security Group Private"
  }
}
*/