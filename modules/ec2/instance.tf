
resource "aws_instance" "bastion" {
    #count = var.ec2_count
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.public-1a
    vpc_security_group_ids = [var.sgforbastion]

    tags = {
      Name = "kapil_bastion"
    }
}
    

resource "aws_instance" "web1a" {
    #count = var.ec2_count
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.public-1a
    vpc_security_group_ids = [var.sgforweb]

    tags = {
      Name = "kapil_web_1a"
    }
}


resource "aws_instance" "web1b" {
    #count = var.ec2_count
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.public-1b
    vpc_security_group_ids = [var.sgforweb]

    tags = {
      Name = "kapil_web_1b"
    }
}

resource "aws_instance" "db1a" {
    #count = var.ec2_count
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.private-1a
    vpc_security_group_ids = [var.sgfordb]

    tags = {
      Name = "kapil_db_1a"
    }
}

resource "aws_instance" "db1b" {
    #count = var.ec2_count
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.private-1b
    vpc_security_group_ids = [var.sgfordb]

    tags = {
      Name = "kapil_db_1b"
    }
}

output "web_1a_id" {
    value = aws_instance.web1a.id
}

output "web_1b_id" {
    value = aws_instance.web1b.id
}

output "db_1a_id" {
    value = aws_instance.db1a.id
}

output "db_1b_id" {
    value = aws_instance.db1b.id
}





