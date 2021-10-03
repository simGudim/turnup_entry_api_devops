module "shared_vars" {
    source = "../shared_vars"
}

variable "privatesg_id" {}

variable "tg_arn" {}


data "aws_ami" "entry_api_ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = ["packer-entry-api-*"]
  }
}


resource "aws_launch_configuration" "entry_api_launch_config" {
    name = "entry-api-launch-config-${module.shared_vars.env_suffix}"
    image_id = "${data.aws_ami.entry_api_ami.id}"
    instance_type = "${module.shared_vars.instancetype}"
    key_name = "${module.shared_vars.keypair}"
    user_data = "${file("./assets/userdata.txt")}"
    security_groups = ["${var.privatesg_id}"]
}

resource "aws_autoscaling_group" "entry_api_autoscaling" {
    name = "entry-api-autoscaling-${module.shared_vars.env_suffix}"
    max_size = "${module.shared_vars.asgmax}"
    min_size = "${module.shared_vars.asgmin}"
    desired_capacity = "${module.shared_vars.asgdesired}"
    launch_configuration = "${aws_launch_configuration.entry_api_launch_config.name}"
    vpc_zone_identifier = ["${module.shared_vars.publicsubnetid1}"]
    target_group_arns = ["${var.tg_arn}"]

    tags = [
        {
            key = "Name"
            value = "entry-api-${module.shared_vars.env_suffix}"
            propagate_at_launch = true
        },
        {
            key = "Environment"
            value = "${module.shared_vars.env_suffix}"
            propagate_at_launch = true
        }
    ]
}