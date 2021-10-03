
#outputs the variable from the resources 
output "vpcid" {
    value = "${local.vpcid}"
}

output "publicsubnetid1" {
    value = "${local.publicsubnetid1}"
}

output "publicsubnetid2" {
    value = "${local.publicsubnetid2}"
}


output "privatesubnetid" {
    value = "${local.privatesubnetid}"
}

output "env_suffix" {
    value = "${local.env}"
}

output "instancetype" {
    value = "${local.instancetype}"
}

output "keypair" {
    value = "${local.keypair}"
}

output "asgdesired" {
    value = "${local.asgdesired}"
}

output "asgmin" {
    value = "${local.asgmin}"
}

output "asgmax" {
    value = "${local.asgmax}"
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
        default = "subnet-5df5a911"
        staging = "subnet-5df5a911"
        production = "subnet-5df5a911"
    }
    publicsubnetid2 = "${lookup(local.publicsubnetid2_env, local.env)}"

    # sets the private subnet id
    privatesubnetid_env = {
        default = "subnet-14a7197f"
        staging = "subnet-14a7197f"
        production = "subnet-14a7197f"
    }
    privatesubnetid = "${lookup(local.privatesubnetid_env, local.env)}"

    instancetype_env = {
        default = "t2.micro"
        staging = "t2.micro"
        production = "t2.medium"
    }
    instancetype = "${lookup(local.instancetype_env, local.env)}"
    
    keypair_env = {
        default = "entry-api-key-pair-staging"
        staging = "entry-api-key-pair-staging"
        production = "entry-api-key-pair-production"
    }
    keypair = "${lookup(local.keypair_env, local.env)}"


    asgdesired_env = {
        default = "1"
        staging = "1"
        production = "2"
    }
    asgdesired = "${lookup(local.asgdesired_env, local.env)}"

    asgmin_env = {
        default = "1"
        staging = "1"
        production = "2"
    }
    asgmin = "${lookup(local.asgmin_env, local.env)}"


    asgmax_env = {
        default = "1"
        staging = "1"
        production = "2"
    }
    asgmax = "${lookup(local.asgmax_env, local.env)}"


    # TODO
    # sets the AMI id, maybe use this later????
    # amiid_env = {
    #     default = "subnet-14a7197f"
    #     staging = "subnet-14a7197f"
    #     production = "subnet-14a7197f"
    # }
    # amiid = "${lookup(local.amiid_env, local.env)}"
}