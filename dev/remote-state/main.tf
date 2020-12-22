
module "my_s3" {
   source = "../../modules/s3"
}

module "my_dynamodb" {
   source = "../../modules/dynamodb"
}
