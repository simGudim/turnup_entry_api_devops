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

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "${module.shared_vars.env_suffix}"
  }
}