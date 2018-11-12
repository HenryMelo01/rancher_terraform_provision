provider "aws" {
  profile = "production"
  region  = "${var.region}"
}
terraform {
  backend "s3" {
    profile = "production"
    bucket  = "99taxis.tfstate"
    key     = "corp/rancher/terraform.tfstate"
    region  = "us-east-1"
  }
}