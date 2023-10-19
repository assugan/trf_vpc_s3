# create Security Group
resource "aws_security_group" "private_sg" {
  vpc_id      = aws_vpc.main.id
  name        = "Security Group Private"
  description = "Security Group Private"
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

resource "aws_security_group" "public_sg" {
  vpc_id      = aws_vpc.main.id
  name        = "Security Group Public"
  description = "Security Group Public"
  ingress {
    cidr_blocks = ["${var.ingress_cidr_pub}"]
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["${var.ingress_cidr_pub}"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
    Name = "Security Group Public"
  }
}