provider "aws" {
    profile = "simGudim2"
    region = "us-east-2"
    ## TODO to be changed to Vault
    access_key = "AKIAZ233Y7KGTWNRTFO4"
    secret_key = "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"
}

module "network_module" {
    source = "./network_module"
}