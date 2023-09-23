# WE INCLUDE ALL THE PROVIDER HERE
terraform {
        required_providers {
                aws = {
                        source = "hashicorp/aws"
                        version = "~> 5.0"
                }
        }
}