
#outputs the vpcid 
output "vpcid" {
    value = "${local.vpcid}"
}

output "publicsubnetid1" {
    value = "${local.publicsubnetid1}"
}

output "publicsubnetid2" {
    value = "${local.publicsubnetid2}"
}


output "privatesubnteid" {
    value = "${local.privatesubnetid}"
}

output "env_suffix" {
    value = "${local.env}"
}

locals {
    env = "${terraform.workspace}"
    # sets the vpc id
    vpcid_env = {
        default = "vpc-3cff6957"
        staging = "vpc-3cff6957"
        production = "vpc-3cff6957"
    }
    vpcid = "${lookup(local.vpcid_env, local.env)}"

    # sets the publick subnet id 1, we use 2 because of the load balancer
    publicsubnetid1_env = {
        default = "subnet-0934c074"
        staging = "subnet-0934c074"
        production = "subnet-0934c074"
    }
    publicsubnetid1 = "${lookup(local.publicsubnetid1_env, local.env)}"

    publicsubnetid2_env = {
        default = "subnet-0934c074"
        staging = "subnet-0934c074"
        production = "subnet-0934c074"
    }
    publicsubnetid2 = "${lookup(local.publicsubnetid2_env, local.env)}"

    # sets the private subnet id
    privatesubnetid_env = {
        default = "subnet-14a7197f"
        staging = "subnet-14a7197f"
        production = "subnet-14a7197f"
    }
    privatesubnetid = "${lookup(local.privatesubnetid_env, local.env)}"
}