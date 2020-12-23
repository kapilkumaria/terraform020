
resource "aws_lb" "kkalb" {
  name               = "kapilterraalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]
  
   
  subnet_mapping {
      subnet_id = var.subnet1a_public
  }

  subnet_mapping {
      subnet_id = var.subnet1b_public
  }


  tags = {
    Name = "kapil-terra-alb"
    }

  ip_address_type = "ipv4"
}


resource "aws_lb_target_group" "logfiles-tg" {
    health_check {
        interval = 10
        path = "/"
        protocol = "HTTP"
        timeout = 5
        healthy_threshold = 5
        unhealthy_threshold = 2 
    }

    name = "my-logfiles-tg"
    port = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = var.alb_vpc_id
     
    tags = {
        Name = "kapil-logfiles-tg"
    }
}

resource "aws_lb_target_group" "images-tg" {
    health_check {
        interval = 10
        path = "/"
        protocol = "HTTP"
        timeout = 5
        healthy_threshold = 5
        unhealthy_threshold = 2 
    }

    name = "my-images-tg"
    port = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = var.alb_vpc_id

    tags = {
        Name = "kapil-images-tg"
    }
}

# resource "aws_lb" "kkalb" {
#   name               = "kapilterraalb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [var.alb_sg]
  
   
#   subnet_mapping {
#       subnet_id = var.subnet1a_public
#   }

#   subnet_mapping {
#       subnet_id = var.subnet1b_public
#   }


#   tags = {
#     Name = "kapil-terra-alb"
#     }

#   ip_address_type = "ipv4"
# }

resource "aws_lb_listener" "logfiles-listener" {
    load_balancer_arn = aws_lb.kkalb.arn 
      port = 80
      protocol = "HTTP"
      default_action {
          target_group_arn = aws_lb_target_group.logfiles-tg.arn
          type = "forward"
      }
}

# resource "aws_lb_listener" "images-listener" {
#     load_balancer_arn = aws_lb.kkalb.arn 
#       port = 80
#       protocol = "HTTP"
#       default_action {
#          target_group_arn = aws_lb_target_group.images-tg.arn
#          type = "forward"
#       }
# }


resource "aws_lb_listener_rule" "logfiles" {
    listener_arn = aws_lb_listener.logfiles-listener.arn
    priority = 100

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.logfiles-tg.arn
    }

    condition {
        path_pattern {
            values = ["/logfiles/*"]
        }
    }
}

resource "aws_lb_listener_rule" "images" {
    listener_arn = aws_lb_listener.logfiles-listener.arn
    priority = 200

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.images-tg.arn
    }

    condition {
        path_pattern {
            values = ["/images/*"]
        }
    }
}






# resource "aws_lb_listener_rule" "images" {
#     listener_arn = aws_lb_listener.images-listener.arn
#     priority = 200

#     action {
#         type = "forward"
#         target_group_arn = aws_lb_target_group.images-tg.arn
#     }

#     condition {
#         path_pattern {
#             values = ["/images/*"]
#         }
#     }
# }

resource "aws_alb_target_group_attachment" "ec2_web1_attach" {
    target_group_arn = aws_lb_target_group.logfiles-tg.arn
    target_id = var.instanceattachment1_id
}

resource "aws_alb_target_group_attachment" "ec2_web2_attach" {
    target_group_arn = aws_lb_target_group.images-tg.arn
    target_id = var.instanceattachment2_id
}

output "alb-id" {
    value = aws_lb.kkalb.id
}

output "alb-dnsname" {
    value = aws_lb.kkalb.dns_name
}
