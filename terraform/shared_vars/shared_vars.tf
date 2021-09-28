
#outputs the vpcid 
output "vpcid" {
    value = "${local.vpcid}"
}

output "publicsubnteid" {
    value = "${local.publicsubnetid}"
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

    # sets the publick subnet id
    publicsubnetid_env = {
        default = "subnet-0934c074"
        staging = "subnet-0934c074"
        production = "subnet-0934c074"
    }
    publicsubnetid = "${lookup(local.publicsubnetid_env, local.env)}"

    # sets the private subnet id
    privatesubnetid_env = {
        default = "subnet-14a7197f"
        staging = "subnet-14a7197f"
        production = "subnet-14a7197f"
    }
    privatesubnetid = "${lookup(local.privatesubnetid_env, local.env)}"
}