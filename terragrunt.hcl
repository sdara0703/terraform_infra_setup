region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

locals {
    aws_region  = local.region_vars.locals.aws_region
}
generate "provider" {
    path        = "provider.tf"
    if_exists   = "overwrite_terragrunt"
    contents    = <<EOF
provider "aws" {
    region = "${local.aws_region}"
}
EOF
}

generate "provider_version" {
    path      = "provider_version_overwrite.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}
EOF
}

# Generate the OpenTofu remote state block for storing state in S3
remote_state {
    backend = "s3"
    config = {
        encrypt     = true
        bucket      = local.state_bucket
        key         = "${path_relative_to_include()}/terraform.tfstate"
        region      = local.aws_region
        dynamodb_table = "terraform-locks"
        accesslogging_bucket_name = local.accesslogging_bucket_name
    }
    generate = {
        path        = "backend.tf"
        if_exists   = "overwrite_terragrunt"
    }
}

# Default Inputs

inputs = {
    #Set globally used inputs here to keep all the child terragrunt.hcl files more DRY.
    aws_region  = local.aws_region
    #name_prefix = local.common_vars_locals.name_prefix
}