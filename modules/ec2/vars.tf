#variable "ec2_count" {
#    default = "1"
#}


variable "ami_id" {}


variable "instance_type" {
    default = "t2.micro"
}

#variable "vpcid" {}

variable "public-1a" {}

variable "public-1b" {}

variable "private-1a" {}

variable "private-1b" {}

variable "sgforbastion" {}

variable "sgforweb" {}

variable "sgfordb" {}