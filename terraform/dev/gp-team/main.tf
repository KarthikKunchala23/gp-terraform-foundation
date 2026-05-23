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
      dynamodb_table = "terraform-lock-table"
      region = "ap-south-1"
      encrypt = true
    }
}

provider "aws" {
    region = "ap-south-1"
    default_tags {
      tags = {
        team = var.team
        environment  = var.environment
        region = "ap-south-1"
        created_by = "gp-terraform-foundation"
      }
    }
}
