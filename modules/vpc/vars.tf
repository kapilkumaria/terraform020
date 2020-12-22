#variable "vpc_name" {
#   description = "Name of VPC"
#  type = string
#  default = "kapilterraformvpc"
#}

variable "vpc_cidr" {
#   description = "CIDR block for VPC"
#   type = string
   default = "192.168.0.0/26"
}

#variable "vpc_azs" {
#   description = "Availability zones for VPC"
#   type = list
#   default = ["ca-central-1a", "ca-central-1b"]
#}

variable "tenancy" {
   default = "default"
}


variable "vpc_id" {}

#variable "subnet_pub_1a_id" {}

#variable "subnet_pub_1b_id" {}

#variable "subnet_pri_1a_id" {}

#variable "subnet_pri_1b_id" {}


################ Variables for Subnets CIDR ####################

variable "pub-subnet_1a_cidr" {
    default = "192.168.0.0/28"
}

variable "pub-subnet_1b_cidr" {
    default = "192.168.0.16/28"
}

variable "pri-subnet_1a_cidr" {
    default = "192.168.0.32/28"
}

variable "pri-subnet_1b_cidr" {
    default = "192.168.0.48/28"
}

################ Variables for Avaialbilty Zones for Subnets ###############

variable "az_pub_1a" {
   default = "ca-central-1a"
}

variable "az_pub_1b" {
   default = "ca-central-1b"
}

variable "az_pri_1a" {
   default = "ca-central-1a"
}

variable "az_pri_1b" {
   default = "ca-central-1b"
}
