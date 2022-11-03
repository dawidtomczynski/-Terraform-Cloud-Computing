resource "aws_security_group" "dawid-terra" {
  name        = var.name
  description = "open http & ssh"
  vpc_id      = var.vpc_id
  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  
    ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
  	Name       = var.name
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }
}

resource "aws_instance" "dawid-terra-1" {
  ami                         = var.ami 
  associate_public_ip_address = true
  instance_type               = var.instance_type
  availability_zone           = var.av_zone_1
  subnet_id                   = var.subnet_id_1
  vpc_security_group_ids      = [aws_security_group.dawid-terra.id]
  user_data = var.entrypoint
  tags = {
  	Name       = "dawid-terra-1"
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }
  volume_tags = {
    Name       = "dawid-terra-1"
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }
}

resource "aws_instance" "dawid-terra-2" {
  count                       = (var.num == true ? 1 : 0)
  ami                         = var.ami
  associate_public_ip_address = true
  instance_type               = var.instance_type
  availability_zone           = var.av_zone_2
  subnet_id                   = var.subnet_id_2
  vpc_security_group_ids      = [aws_security_group.dawid-terra.id]
  user_data = var.entrypoint 
  tags = {
    Name       = "dawid-terra-2"
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }  
  volume_tags = {
    Name       = "dawid-terra-2"
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }
}

resource "aws_lb_target_group" "dawid-terra" {
  count    = (var.num == true ? 1 : 0)
  name     = var.name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
  	Name       = var.name
    bootcamp   = var.bootcamp
    created_by = var.created_by
  } 
}

resource "aws_lb_target_group_attachment" "dawid-terra-1" {
  count            = (var.num == true ? 1 : 0)
  target_group_arn = aws_lb_target_group.dawid-terra[count.index].arn
  target_id        = aws_instance.dawid-terra-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "dawid-terra-2" {
  count            = (var.num == true ? 1 : 0)
  target_group_arn = aws_lb_target_group.dawid-terra[count.index].arn
  target_id        = aws_instance.dawid-terra-2[count.index].id
  port             = 80
}

resource "aws_lb" "dawid-terra" {
  count              = (var.num == true ? 1 : 0)
  name               = var.name
  security_groups    = [aws_security_group.dawid-terra.id]
  subnets            = [var.subnet_id_1, var.subnet_id_2]
  tags = {
  	Name       = var.name
    bootcamp   = var.bootcamp
    created_by = var.created_by
  }
}

resource "aws_lb_listener" "dawid-terra" {
  count             = (var.num == true ? 1 : 0)
  load_balancer_arn = aws_lb.dawid-terra[count.index].arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dawid-terra[count.index].arn
  }
}
