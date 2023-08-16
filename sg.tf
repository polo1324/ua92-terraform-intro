resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "SG for ecs app"
  vpc_id      = aws_vpc.my_vpc.id
}

resource "aws_security_group_rule" "lb_to_ecs" {
  type                     = "ingress"
  description              = "alb to ecs."
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "ecs_outbound" {
  type              = "egress"
  description       = "outbound on port 80."
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_sg.id
}

resource "aws_security_group_rule" "ecs_outbound_https" {
  type              = "egress"
  description       = "outbound on port 80."
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_sg.id
}


resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "SG for app loadbalancer"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allows inbound HTTP Connections"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description     = "Allow Outbound to ECS on port 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }
}