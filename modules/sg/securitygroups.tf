
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

    tags = {
      Name = "kapil_albsg"
    }
}


output "BASTION_SG_ID" {
     value = aws_security_group.bastionsg.id
}

output "WEB_SG_ID" {
     value = aws_security_group.websg.id
}


output "DB_SG_ID" {
     value = aws_security_group.dbsg.id
}

output "ALB_SG_ID" {
     value = aws_security_group.albsg.id
}



