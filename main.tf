provider "aws" {
  profile = "production"
  region  = "${var.region}"
}
terraform {
  backend "s3" {
    profile = "production"
    bucket  = ""
    key     = ""
    region  = ""
  }
}
