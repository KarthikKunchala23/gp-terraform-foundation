terraform {
    required_version = ">= 1.0"

    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = ">= 4.0"
      }
    }

    backend "s3" {
      bucket = "gp-project-s3-cindia"
      key = "sg_test/terraform.tfstate"
      # dynamodb_table = "terraform-lock-table"
      use_lockfile = true
      region = "ap-south-1"
      encrypt = true
    }
}

provider "aws" {
    region = "ap-south-1"
    default_tags {
      tags = {
        Team = var.team
        Environment = var.environment
        Region = "ap-south-1"
        Created_By = "gp-terraform-foundation"
      }
    }
}
