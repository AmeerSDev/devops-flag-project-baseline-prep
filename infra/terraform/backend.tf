# terraform {
#   backend "s3" {
#     bucket         = "tf-ans-lab1-s3-bucket-2"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "tf-ans-lab1-locks"
#     encrypt        = true
#   }
# }
