terraform {
  required_version = ">= 1.5.4"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"] #path to your own credentials file may vary
  profile = "PROFILE_NAME"
  region = "eu-west-1"
}