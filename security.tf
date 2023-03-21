resource "aws_security_group" "ec2" {
  name        = "allow_jfrog"
  description = "Allow jfrog outbound traffic"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_jfrog"
  }
}
