variable publicsg_id {}

module "shared_vars" {
    source = "../shared_vars"
}

resource "aws_lb" "entry_api_lb" {
  name               = "entry-api-lb-${module.shared_vars.env_suffix}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.publicsg_id]
  subnets            = ["${module.shared_vars.publicsubnetid1}", "${module.shared_vars.publicsubnetid2}"]

  enable_deletion_protection = false

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.bucket
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = "${module.shared_vars.env_suffix}"
  }
}

resource "aws_lb_target_group" "entry_api_tg" {
  name     = "entry-api-tg-${module.shared_vars.env_suffix}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${module.shared_vars.vpcid}"
}

output "tg_arn" {
  value = "${aws_lb_target_group.entry_api_tg.arn}"
}

resource "aws_lb_listener" "http_listener_80" {
  ## new way of module interpolation
  load_balancer_arn = aws_lb.entry_api_lb.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.entry_api_tg.arn
  }
}