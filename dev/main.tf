provider "aws" {
   region = "ca-central-1"
}


terraform {
   backend "s3" {
      bucket = "backend-bucket-for-terraform018"
      key = "global/s3/terraform.tfstate"
      region = "ca-central-1"

      dynamodb_table = "terraform-up-and-running-locks"
      encrypt = true
   }
}


module "vpc" {
   source = "../modules/vpc"
   vpc_cidr = "192.168.0.0/26"
   tenancy = "default"
   vpc_id = module.vpc.vpc_id
   pub-subnet_1a_cidr = "192.168.0.0/28"
   pub-subnet_1b_cidr = "192.168.0.16/28"
   pri-subnet_1a_cidr = "192.168.0.32/28"
   pri-subnet_1b_cidr = "192.168.0.48/28"
}

module "sg" {
   source = "../modules/sg"
   terravpcid = module.vpc.vpc_id
}

module "eip" {
   source = "../modules/eip"
}

module "ec2" {
   source = "../modules/ec2"
   #ec2_count = 1
   ami_id = "ami-02e44367276fe7adc"
   instance_type = "t2.micro"
   #vpc_id = module.vpc.vpc_id
   public-1a = module.vpc.public-1a
   public-1b = module.vpc.public-1b
   private-1a = module.vpc.private-1a
   private-1b = module.vpc.private-1b
   sgforbastion = module.sg.bastion_sg
   sgforweb = module.sg.web_sg 
   sgfordb = module.sg.db_sg
}

module "my_alb" {
   source = "../modules/alb"
   public-1a = module.vpc.public-1a
   alb_vpc_id = module.vpc.vpc_id
   alb_sg = module.sg.alb_sg
   subnet1a_public = module.vpc.public-1a
   subnet1b_public = module.vpc.public-1b
   instanceattachment1_id = module.ec2.web_1a_id
   instanceattachment2_id = module.ec2.web_1b_id
}

# resource "aws_instance" "myinstance" {
#    ami = "ami-02e44367276fe7adc"
#    instance_type = "t2.micro"
#    subnet_id = module.vpc.public-1a
   
#    tags = {
#       Name = "kapil_instance"
#    }
# }

output "VPC_ID" {
   value = module.vpc.vpc_id
}

output "IGW_ID" {
   value = module.vpc.igw_id
}


output "SUBNET_PUBLIC_1a" {
   value = module.vpc.public-1a
}

output "SUBNET_PUBLIC_1b" {
   value = module.vpc.public-1b
}

output "SUBNET_PRIVATE_1a" {
   value = module.vpc.private-1a
}

output "SUBNET_PRIVATE_1b" {
   value = module.vpc.private-1b
}

output "BASTION_SG_ID" {
     value = module.sg.bastion_sg
}

output "WEB_SG_ID" {
     value = module.sg.web_sg
}

output "DB_SG_ID" {
     value = module.sg.db_sg
}

output "ALB_SG" {
     value = module.sg.alb_sg
}

output "PUBLIC_RT_ID" {
   value = module.vpc.public_rt_id
}

output "EIP_ID" {
   value = module.eip.eip_id
}

output "PRIVATE_RT_ID" {
   value = module.vpc.public_rt_id
}

output "NAT_ID" {
   value = module.vpc.nat_id
}

output "WEBSERVER_1a_ID" {
   value = module.ec2.web_1a_id
}

output "WEBSERVER_1b_ID" {
   value = module.ec2.web_1b_id
}

output "DBSERVER_1a_ID" {
   value = module.ec2.db_1a_id
}

output "DBSERVER_1b_ID" {
   value = module.ec2.db_1b_id
}

output "ALB_ID" {
   value = module.my_alb.alb-id
}

output "ALB_DNS_NAME" {
   value = module.my_alb.alb-dnsname
}






