
resource "aws_security_group" "bastionsg" {
    name = "bastionsg"
    description = "security group for bastion server"
    vpc_id = var.terravpcid
    
    ingress {
      description = "Allow SSH connection from my computer only"
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["66.222.146.176/32"]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "kapil_bastionsg"
    }
}


resource "aws_security_group" "websg" {
    name = "websg"
    description = "security group for web servers"
    vpc_id = var.terravpcid

    ingress {
      description = "Allow SSH connection from bastion server only"
      from_port = 22
      to_port = 22
      protocol = "TCP"
      security_groups = [aws_security_group.bastionsg.id]
    }

    ingress {
      description = "Allow HTTP traffic from application LB only"
      from_port = 80
      to_port = 80
      protocol = "TCP"
      security_groups = [aws_security_group.albsg.id]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "kapil_websg"
    }
}


resource "aws_security_group" "dbsg" {
    name = "dbsg"
    description = "security group for database servers"
    vpc_id = var.terravpcid

    ingress {
      description = "Allow SSH connection from bastion server only"
      from_port = 22
      to_port = 22
      protocol = "TCP"
      security_groups = [aws_security_group.bastionsg.id]
    }

    ingress {
      description = "Allow HTTP traffic from web servers only"
      from_port = 80
      to_port = 80
      protocol = "TCP"
      security_groups = [aws_security_group.websg.id]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "kapil_dbsg"
    }
}


resource "aws_security_group" "albsg" {
    name = "albsg"
    description = "security group for application load balancer"
    vpc_id = var.terravpcid

    ingress {
      description = "Allow HTTP traffic from internet"
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
      Name = "kapil_albsg"
    }
}


output "bastion_sg" {
     value = aws_security_group.bastionsg.id
}

output "web_sg" {
     value = aws_security_group.websg.id
}

output "db_sg" {
     value = aws_security_group.dbsg.id
}

output "alb_sg" {
     value = aws_security_group.albsg.id
}



