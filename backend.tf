terraform {

  backend "s3" {
    bucket                  = "ENTER_YOUR_BUCKET_NAME"
    key                     = "terraform/terraform.tfstate"
    region                  = "eu-west-1"
    encrypt                 = "true"
    shared_credentials_file = "~/.aws/credentials" #path to your own credentials file may vary
    profile                 = "PROFILE_NAME"
  }

}