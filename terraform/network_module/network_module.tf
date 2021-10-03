# import the network module
module "shared_vars" {
    source = "../shared_vars"
}


# set publick security group for the load balancer
resource "aws_security_group" "publicsg" {
    name = "publicsg_${module.shared_vars.env_suffix}"
    description = "public security group for load balancers in the Entry API ${module.shared_vars.env_suffix}"
    vpc_id = "${module.shared_vars.vpcid}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "publicsg_id" {
    value = "${aws_security_group.publicsg.id}"
}

# set the security group for the EC2 instance
resource "aws_security_group" "privatesg" {
    name = "privatesg_${module.shared_vars.env_suffix}"
    description = "private security group for the EC2 on Entry API ${module.shared_vars.env_suffix}"
    vpc_id = "${module.shared_vars.vpcid}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_groups = ["${aws_security_group.publicsg.id}"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "privatesg_id" {
    value = "${aws_security_group.privatesg.id}"
}