function buildImage {
  export AWS_ACCESS_KEY=AKIAZ233Y7KGTWNRTFO4
  export AWS_SECRET_KEY=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
  export AWS_DEFAULT_REGION=us-east-2
  packer build packer_entry_api_ami.json
}

# build the image
buildImage 