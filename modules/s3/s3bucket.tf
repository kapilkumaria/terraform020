
resource "aws_s3_bucket" "kkbucket" {
     bucket = "backend-bucket-for-terraform018"
     acl = "private"

     versioning {
         enabled = true
     }

     server_side_encryption_configuration {
         rule {
             apply_server_side_encryption_by_default {
                 sse_algorithm = "AES256"
             }
         }
     }
    }

    


     


#output "backendbucket-id" {
#    value = aws_s3_bucket.kkbucket.id
#}


#output "pathtobucketkey" {
#    value = aws_s3_bucket.kkbucket.id
#}