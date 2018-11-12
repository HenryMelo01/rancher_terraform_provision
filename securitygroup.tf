resource "aws_security_group" "rancher_sg_allowports" {
  name   = "${var.prefix}-sg"
  vpc_id = "${var.aws_vpc}"


  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2379
    protocol    = "tcp"
    to_port     = 2380
    self        = true
  }
  ingress {
    from_port   = 10248
    protocol    = "tcp"
    to_port     = 10257
    self        = true
  }
  ingress {
    from_port   = 6443
    protocol    = "tcp"
    to_port     = 6443
    self        = true
  }
  ingress {
    from_port   = 6781
    protocol    = "tcp"
    to_port     = 6781
    self        = true
  }
  ingress {
    from_port   = 37696
    protocol    = "tcp"
    to_port     = 37696
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}